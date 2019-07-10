#===============================================================================
# 2019-07-10-- BSSD dataviz
# Reprodice Figure 2 from http://doi.org/10.1007/s10708-018-9953-5
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================


library(tidyverse)
library(hrbrthemes); import_roboto_condensed()


df <- tibble::tribble(
        ~ cohort,
        ~ region,
        ~ change_cens,
        ~ change_rolling,
        "Cohort 1988-1992",
        "Belgorod region",
        5.02336558,
        4.261994175,
        "Cohort 1988-1992",
        "Brynsk region",
        -8.745338626,
        -2.778780224,
        "Cohort 1988-1992",
        "Vladimir region",
        2.231492185,
        -1.639443132,
        "Cohort 1988-1992",
        "Voronezh region",
        11.36904153,
        2.577741408,
        "Cohort 1988-1992",
        "Ivanovo region",
        7.691787857,
        0.029734552,
        "Cohort 1988-1992",
        "Tver\' region",
        -5.62273339,
        -1.699251056,
        "Cohort 1988-1992",
        "Kaluga region",
        1.4661713,
        -2.669001153,
        "Cohort 1988-1992",
        "Kostroma region",
        -13.60146181,
        -3.621483973,
        "Cohort 1988-1992",
        "Kursk region",
        -11.86713734,
        -1.384775759,
        "Cohort 1988-1992",
        "Lipetsk region",
        -5.494946059,
        -2.762659151,
        "Cohort 1988-1992",
        "MOSCOW",
        59.13077164,
        11.43789158,
        "Cohort 1988-1992",
        "Moscow region",
        27.5933042,
        7.569113299,
        "Cohort 1988-1992",
        "Orel region",
        -3.178163498,
        -0.973118465,
        "Cohort 1988-1992",
        "Ryazan region",
        4.170185944,
        -0.718562874,
        "Cohort 1988-1992",
        "Smolensk region",
        1.675431261,
        -2.613786163,
        "Cohort 1988-1992",
        "Tambov region",
        -5.299519021,
        -2.18751952,
        "Cohort 1988-1992",
        "Tula region",
        1.515377502,
        -1.520349213,
        "Cohort 1988-1992",
        "Yaroslavl region",
        0.277742417,
        2.226568377,
        "Cohort 1988-1992",
        "CFD TOTAL",
        17.91717361,
        3.494765114,
        "Cohort 1980-1984",
        "Belgorod region",
        5.181815024,
        4.964748376,
        "Cohort 1980-1984",
        "Brynsk region",
        -1.907313367,
        -4.806269743,
        "Cohort 1980-1984",
        "Vladimir region",
        -5.704141813,
        -3.185233172,
        "Cohort 1980-1984",
        "Voronezh region",
        -0.038014311,
        -2.626900716,
        "Cohort 1980-1984",
        "Ivanovo region",
        -10.2483576,
        -3.651012074,
        "Cohort 1980-1984",
        "Tver\' region",
        -1.026552733,
        -2.051193822,
        "Cohort 1980-1984",
        "Kaluga region",
        1.348068524,
        -1.371983838,
        "Cohort 1980-1984",
        "Kostroma region",
        -7.482715831,
        -4.951249778,
        "Cohort 1980-1984",
        "Kursk region",
        -4.879176783,
        -5.152040698,
        "Cohort 1980-1984",
        "Lipetsk region",
        6.864917673,
        -1.208092072,
        "Cohort 1980-1984",
        "MOSCOW",
        22.43231231,
        7.115724936,
        "Cohort 1980-1984",
        "Moscow region",
        9.743441547,
        12.93424645,
        "Cohort 1980-1984",
        "Orel region",
        -8.768544586,
        -4.678455066,
        "Cohort 1980-1984",
        "Ryazan region",
        -6.549329107,
        -3.137073606,
        "Cohort 1980-1984",
        "Smolensk region",
        -3.186131974,
        -5.39848303,
        "Cohort 1980-1984",
        "Tambov region",
        -3.175896786,
        -8.10963301,
        "Cohort 1980-1984",
        "Tula region",
        -1.353086337,
        -2.566111982,
        "Cohort 1980-1984",
        "Yaroslavl region",
        -7.4401387,
        0.662574387,
        "Cohort 1980-1984",
        "CFD TOTAL",
        6.896848972,
        3.058201047
)



# relevel regions ascending 
df_plot <- df %>% 
        #mutate(max_change = pmax(change_cens, change_rolling)) %>% 
        select(cohort, region, change_cens) %>% 
        spread(cohort, change_cens) %>% 
        arrange(`Cohort 1988-1992`) %>% 
        mutate(
                region = region %>% 
                        as_factor %>% 
                        fct_relevel("CFD TOTAL", after = 0)
        ) %>% 
        arrange(region) %>%
        gather("cohort", "value", 2:3) %>% 
        left_join(df, by = c("region", "cohort")) 

breaks <- 1:length(unique(df_plot$region))
labels <- df_plot %>% pull(region) %>% unique
pal <- c("#8C510A", "#003C30")


df_plot %>% 
        mutate(region = region %>% as_factor,
               y = region %>% as.numeric,
               adjust = ifelse(cohort=="Cohort 1988-1992", .15, -.15),
               ypos = y - adjust) %>% 
        ggplot(aes(color = cohort, y = ypos))+
        geom_vline(xintercept = 0, size = 2, alpha = .5, color = "grey50")+
        geom_segment(aes(x = change_cens, xend = change_rolling, yend = ypos))+
        geom_point(aes(x = change_cens), shape = 16, size = 2)+
        geom_point(aes(x = change_rolling), shape = 21, size = 2, fill = "white")+
        scale_color_manual(values = pal)+
        scale_y_continuous(breaks = breaks, labels = labels, expand = c(.01, .01))+
        theme_minimal(base_family = font_rc, base_size = 12)+
        theme(legend.position = "none", 
              panel.grid.minor.y = element_blank(),
              panel.grid.major.y = element_line(size = 4, color = "grey95"),
              axis.text.y = element_text(vjust = .3, size = 12))+
        labs(x = "Change in cohort size, 2003-2010, %", y = NULL)+
        # add legend manually
        annotate("rect", xmin = 29, xmax = 63, ymin = 2.5, ymax = 9.5,
                 color = "grey50", fill = "white")+
        annotate("text", x = 45, y = 8.5, label = "LEGEND", 
                 size = 5, hjust = .5, family = font_rc, color = "grey20")+
        annotate("text", x = 45, y = 7, label = "Change in cohort size by", 
                 size = 4.5, hjust = .5, family = font_rc, color = "grey20")+
        annotate("point", x = c(32.5, 47.5), y = 6, 
                 pch = c(16, 21), size = 2, color = 1)+
        annotate("text", x = c(35, 50), y = 6, 
                 label = c("census", "stat record"), 
                 size = 4.5, hjust = 0, family = font_rc, color = "grey20")+
        annotate("text", x = 45, y = 4.5, label = "Cohorts born in", 
                 size = 4.5, hjust = .5, family = font_rc, color = "grey20")+
        annotate("segment", x = c(32, 47), xend = c(34, 49), 
                 y = 3.5, yend = 3.5, 
                 pch = c(16, 21), size = 2, color = pal)+
        annotate("text", x = c(35, 50), y = 3.5, 
                 label = c("1980-84", "1988-92"), 
                 size = 4.5, hjust = 0, family = font_rc, color = "grey20")
