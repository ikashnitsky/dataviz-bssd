#===============================================================================
# 2019-07-09 -- BSSD dataviz
# Population pyramid example
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================


# load the package
library(tidyverse)
library(readxl)




# download eurostat data
library(eurostat)

eu_pop <- get_eurostat("demo_pjan")


df_dk <- eu_pop %>% 
    filter(
        !age %in% c("TOTAL", "UNK", "Y_OPEN"),
        geo == "DK"
    ) %>% 
    mutate(
        year = time %>% lubridate::year(),
        age = age %>% 
            paste %>% 
            str_replace("Y_LT1", "Y_0") %>% 
            str_remove("_") %>%  
            str_remove("Y") %>% 
            as.numeric()
    ) %>% 
    arrange(time, sex, age)


df_dk %>% 
    filter(
        year == 2018, sex == "T"
    ) %>% 
    ggplot(aes(age, values))+
    geom_step()
    
    
# both sex, coord_flip    

df_dk %>% 
    filter(
        year == 2018, !sex == "T"
    ) %>% 
    spread(sex, values) %>% 
    ggplot(aes(age))+
    geom_col(aes(y = `F`), width = 1, 
             fill = "purple")+
    geom_col(aes(y = -M), width = 1,
             fill = "orange", color = NA)+
    coord_flip()


df_dk %>% 
    filter(
        year == 2018, !sex == "T"
    ) %>% 
    spread(sex, values) %>% 
    ggplot(aes(age))+
    geom_hline(yintercept = 0, size = .5, color = "gray20")+
    geom_step(aes(y = `F`), color = "purple")+
    geom_step(aes(y = -M), color = "orange")+
    coord_flip()+
    scale_y_continuous(
        breaks = seq(-40000, 40000, 10000),
        labels = seq(-40000, 40000, 10000) %>% abs %>% paste %>% 
            str_replace("0000", "0K")
    )

library(magrittr)

df_dk %>% 
    filter(
        year %in% c(1960, 2018), !sex == "T"
    ) %>% 
    spread(sex, values) %>% 
    ggplot(aes(age))+
    geom_hline(yintercept = 0, size = .5, color = "gray20")+
    geom_step(aes(y = `F`), color = "purple")+
    geom_step(aes(y = -M), color = "orange")+
    coord_flip()+
    # hrbrthemes::scale_y_comma()
    scale_y_continuous(
        breaks = seq(-40000, 40000, 10000),
        labels = seq(-40000, 40000, 10000) %>% 
            abs %>% divide_by(1e3) %>% as.character()  %>% paste0(., "K")

    )+
    facet_wrap(~year)



df_dk %>% 
    filter(
        year %in% c(1960, 2018), !sex == "T"
    ) %>% 
    spread(sex, values) %>% 
    ggplot(aes(age))+
    geom_hline(yintercept = 0, size = .5, color = "gray20")+
    geom_path(aes(y = `F`, linetype = year %>% factor), color = "purple")+
    geom_path(aes(y = -M, linetype = year %>% factor), color = "orange")+
    coord_flip()+
    # hrbrthemes::scale_y_comma()
    scale_y_continuous(
        breaks = seq(-40000, 40000, 10000),
        labels = seq(-40000, 40000, 10000) %>% 
            abs %>% divide_by(1000) %>% as.character()  %>% paste0(., "K")
        
    )+
    annotate(geom = "text", x = 100, y = -4e4, label = "MALES", hjust = 0, vjust = 1)+
    annotate(geom = "text", x = 100, y = 4e4, label = "FEMALES", hjust = 1, vjust = 1)



# compare two countries ---------------------------------------------------

df_two <- eu_pop %>% 
    filter(
        !age %in% c("TOTAL", "UNK", "Y_OPEN"),
        geo %in% c("IT", "BG")
    ) %>% 
    mutate(
        year = time %>% lubridate::year(),
        age = age %>% 
            paste %>% 
            str_replace("Y_LT1", "Y_0") %>% 
            str_remove("_") %>%  
            str_remove("Y") %>% 
            as.numeric()
    ) %>% 
    arrange(time, sex, age) %>% 
    group_by(sex, geo, time) %>% 
    mutate(values = values / sum(values))


df_two %>% 
    filter(
        year == 2018, sex == "T"
    ) %>% 
    ggplot(aes(age, values, color = geo))+
    geom_step()+
    coord_cartesian(expand = F)+
    scale_y_continuous(labels = scales::percent)+
    theme_minimal()+
    theme(legend.position = c(.9,.9))


plot_two_pop <- function(cntr = c("IT", "BG")) {
    
    df_two <- eu_pop %>% 
        filter(
            !age %in% c("TOTAL", "UNK", "Y_OPEN"),
            geo %in% cntr 
        ) %>% 
        mutate(
            year = time %>% lubridate::year(),
            age = age %>% 
                paste %>% 
                str_replace("Y_LT1", "Y_0") %>% 
                str_remove("_") %>%  
                str_remove("Y") %>% 
                as.numeric()
        ) %>% 
        arrange(time, sex, age) %>% 
        group_by(sex, geo, time) %>% 
        mutate(values = values / sum(values))
    
    
    df_two %>% 
        filter(
            year == 2018, sex == "T"
        ) %>% 
        ggplot(aes(age, values, color = geo))+
        geom_step()+
        coord_cartesian(expand = F)+
        scale_y_continuous(labels = scales::percent)+
        theme_minimal()+
        theme(legend.position = c(.9,.9))
}


c("UK", "ES", "IT") %>% plot_two_pop()


ncntr %>% plot_two_pop()



gg <- ncntr %>% plot_two_pop()

library(plotly)

ggplotly(gg) 
