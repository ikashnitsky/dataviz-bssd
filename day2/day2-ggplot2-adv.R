#===============================================================================
# 2019-07-09-- BSSD dataviz
# ggplot2 adv
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load the packages
library(tidyverse)
library(janitor)
library(scales)



# let's re-create the simplest plot
ggplot(data = swiss,
       aes(x = Agriculture, y = Fertility)) +
    geom_point()

# and save it in an object
gg <- last_plot()


# stat operations ---------------------------------------------------------

# stat_smooth
gg + stat_smooth()

# linear model
gg + stat_smooth(method = "lm")

# remove confidence intervals
gg + stat_smooth(method = "lm", se = F, col = "red")


# stat_ellipse
swiss %>%
    ggplot(aes(x = Agriculture, y = Fertility,
               color = Catholic > 50)) +
    geom_point() +
    stat_ellipse() +
    theme_minimal(base_family = "mono")



# more geoms --------------------------------------------------------------

# density / ecdf (airquality)

ggplot(airquality) +
    geom_density(aes(x = Temp, color = factor(Month)), size = 1) +
    scale_color_viridis_d(option = "D", end = .8) +
    theme_minimal() +
    theme(legend.position = c(.1, .8))

ggplot(airquality) +
    stat_ecdf(aes(x = Temp, color = factor(Month)), size = 1) +
    scale_color_viridis_d(option = "B", end = .8) +
    theme_fivethirtyeight() +
    theme(legend.position = c(.1, .8))


# boxplot
ggplot(airquality) +
    geom_boxplot(aes(x = factor(Month), y = Temp))

# violin
ggplot(airquality) +
    geom_violin(aes(
        x = factor(Month),
        y = Temp,
        fill = factor(Month)
    ))

# jitter
ggplot(airquality) +
    geom_jitter(aes(
        x = factor(Month),
        y = Temp,
        color = factor(Month)
    ),
    width = .2)


library(gapminder)

gapminder %>%
    ggplot(aes(x = year, y = lifeExp,
               color = continent)) +
    geom_jitter(size = 1,
                alpha = .2,
                width = .75) +
    stat_summary(geom = "path", fun.y = mean, size = 1) +
    theme_minimal(base_family = "mono")

gg <- last_plot()



# themes
gg + theme_minimal()
gg + theme_bw()
gg + theme_light()
gg + theme_excel()    # ugly, isn"t it?
gg + theme_few()      # one of my favorites
gg + theme_economist()
gg + theme_wsj()
gg + theme_fivethirtyeight() # I love this one
gg + theme_solarized()
gg + theme_dark()
# ... feel free to test them all))



# ggridges ----------------------------------------------------------------

# https://twitter.com/ikashnitsky/status/886978944985071616

library(ggridges)
library(wpp2015)

# get the UN country names
data(UNlocations)

countries <- UNlocations %>% pull(name) %>% paste

# data on male life expectancy at birth
data(e0M)

e0M %>% 
    filter(country %in% countries) %>%
    select(-last.observed) %>%
    gather(period, value, 3:15) %>%
    ggplot(aes(x = value, y = period %>% fct_rev())) +
    geom_density_ridges(aes(fill = period)) +
    scale_fill_viridis_d(
        option = "B",
        direction = -1,
        begin = .1,
        end = .9
    ) +
    labs(
        x = "Male life expectancy at birth",
        y = "Period",
        title = "Global convergence in male life expectancy at birth since 1950",
        subtitle = "UNPD World Population Prospects 2015 Revision, via wpp2015",
        caption = "ikashnitsky.github.io"
    ) +
    theme_minimal(base_family =  "mono") +
    theme(legend.position = "none")




# label lines hack --------------------------------------------------------

# https://twitter.com/ikashnitsky/status/1045428469801385987
