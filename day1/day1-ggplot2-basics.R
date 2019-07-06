#===============================================================================
# 2019-07-08-- BSSD dataviz
# ggplot2 basics
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load the packages
library(tidyverse)
library(janitor)


# base --------------------------------------------------------------------


# automatic plots for linear model
obj <- lm(data = swiss, Fertility ~ Education)
plot(obj)



# blank map
library(rgdal)
shapefile <- readOGR("data/.", "shape-france")
plot(shapefile)



# ggplot2 -----------------------------------------------------------------

# The logic


ggplot()

swiss %>% View

? swiss



# geom_point
ggplot(data = swiss,
       aes(x = Agriculture, y = Fertility)) +
    geom_point()

gg <- last_plot()

# saving a plot
ggsave(filename = "out/test.png", plot = gg)

# we can also save a plot as an R object
save(gg, file = "out/gg_swiss.rda")



# basic geoms -------------------------------------------------------------

# line / path
df_aq <- airquality %>%
    clean_names() %>%
    mutate(
        date = paste(day, month, "1973", sep = "-") %>%  lubridate::dmy(),
        month = month %>% factor
    )



ggplot(df_aq) +
    geom_line(aes(x = date, y = temp))


df_aq %>%
    ggplot(aes(x = date, y = temp)) +
    geom_path()


df_aq %>%
    ggplot(aes(x = day, y = temp, group = month)) +
    geom_line()

df_aq %>%
    ggplot(aes(x = day, y = temp, color = month)) +
    geom_line()

df_aq %>%
    ggplot(aes(x = date, y = temp, color = month)) +
    geom_line()



library(gapminder)

gapminder %>%
    select(1:4) %>%
    group_by(continent, year) %>%
    summarise(avg_e0 = lifeExp %>% mean) %>%
    ungroup() %>%
    ggplot(aes(x = year, y = avg_e0,
           color = continent)) +
    geom_path(size = 1) +
    theme_minimal(base_family = "mono")






load("data/Denmark.Rdata")

df %>%
    filter(year == "y2004", sex == "m",!age %in% c("total", "open")) %>%
    ggplot() +
    geom_line(aes(
        x = age,
        y = mx,
        group = region,
        color = region
    )) +
    scale_y_continuous(trans = "log", breaks = c(.0001, .001, .01)) +
    theme_minimal()





# faceting ----------------------------------------------------------------

# plot wind against tempreture
df_aq %>% 
    ggplot(aes(wind, temp))+
    geom_point()

# distinguish months by colors
df_aq %>% 
    ggplot(aes(wind, temp, color = month))+
    geom_point()

# let's see them separately with faceting
df_aq %>% 
    ggplot(aes(wind, temp, color = month))+
    geom_point()+
    facet_wrap(~ factor(month), ncol = 3)



# control layout ----------------------------------------------------------

gg
