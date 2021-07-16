#===============================================================================
# 2021-07-16 -- BSSD dataviz
# Replicate Fig A1a from https://doi.org/10.1073/pnas.2010588118
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com, @ikashnitsky
#===============================================================================

# Zarulli V, Kashnitsky I, Vaupel JW. 2021. Death rates at specific life stages mold the sex gap in life expectancy. Proceedings of the National Academy of Sciences 118 DOI: 10.1073/pnas.2010588118


library(tidyverse)
library(magrittr)
library(hrbrthemes)

# plot faceted death risk ratio for 33 HMD countries
data_url <- "https://raw.github.com/ikashnitsky/sex-gap-e0-pnas/main/dat/lt33.rda"
tmp <- tempfile()
download.file(url = data_url, destfile = tmp, mode = "wb")
load(tmp)
unlink(tmp)


# clean up the dataset and calc m/f ratio
mf33 <- lt33 %>%
    # filter out last available year
    group_by(sex, country, age) %>%
    filter(year == year %>% last(),
           age %>% is_less_than(96)) %>%
    ungroup() %>%
    select(1:4, name,  6) %>%
    pivot_wider(names_from = sex, values_from = qx) %>%
    mutate(
        country = country %>% as_factor %>% fct_inorder(),
        name = name %>% as_factor %>% fct_inorder(),
        ratio = m / f
    )


# plot
mf33 %>%
    ggplot(aes(age, y = ratio))+
    geom_hline(yintercept = 1, color = "gray25",  size = .5)+
    geom_smooth(data = . %>% select(-name), aes(group = country), se = F,
                span = .25,
                size = .25, color = "grey75")+
    geom_point(shape = 1, size = 1, color = "#df356b")+
    geom_smooth(se = F, size = 1, color = "#ffffff", span = .25)+
    geom_smooth(se = F, size = .5, color = "#df356b", span = .25)+
    geom_text(aes(label = year), x = 47.5, y = -.1,
              size = 4, color = "grey75",
              vjust = 1, fontface = 2)+
    scale_x_continuous(breaks = c(0, 15, 40, 60, 80))+
    scale_y_continuous(
        trans = "log",
        breaks = c(.5, 1, 2, 3),
        labels = c("", 1, 2, 3),
        limits = c(.75, 3.5)
    )+
    facet_wrap(~name, ncol = 5, dir = "v")+
    theme_minimal(base_family = font_rc, base_size = 16)+
    theme(
        legend.position = "bottom",
        panel.grid.minor = element_blank()
    )+
    labs(
        y = "Sex ratio, log scale",
        x = "Age",
        title = "A. Ratio of male to female probability of death, last available year"
    )

ggsave(
    filename = "~/Downloads/appendix-1a.png",
    width = 8, height = 10,
    type = "cairo-png"
)



# illustrate on one country -----------------------------------------------

mf33 %>%
    filter(country == "DNK") %>%
    ggplot(aes(age, y = ratio))+
    geom_hline(yintercept = 1, color = "gray25",  size = .5)+
    geom_line(shape = 1, size = 1, color = "#df356b")+
    geom_point(shape = 16, size = 3, color = "#df356b")+
    # geom_smooth(se = F, size = 1, color = "#ffffff", span = .25)+
    # geom_smooth(se = F, size = .5, color = "#df356b", span = .25)+
    geom_text(aes(label = year), x = 47.5, y = -.1,
              size = 4, color = "grey75",
              vjust = 1, fontface = 2)+
    scale_x_continuous(breaks = c(0, 15, 40, 60, 80))+
    scale_y_continuous(
        trans = "log",
        breaks = c(.5, 1, 2, 3),
        labels = c("", 1, 2, 3),
        limits = c(.75, 3.5)
    )+
    theme_minimal(base_family = font_rc, base_size = 16)+
    theme(
        legend.position = "bottom",
        panel.grid.minor = element_blank()
    )+
    labs(
        y = "Sex ratio, log scale",
        x = "Age",
        title = "A. Ratio of male to female probability of death, last available year"
    )
