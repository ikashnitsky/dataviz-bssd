#===============================================================================
# 2019-07-10-- BSSD dataviz
# ggplot2 colors and fonts
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load the packages
library(tidyverse)
library(janitor)
library(ggthemes)

# colors ------------------------------------------------------------------

# Parameter "color" changes the color of lines and points
# Parameter "fill" changes the color of shapes (see the violin example)
# The way you override ggplot"s defaults is to use functions
# scale_color_[...] or scale_fill_[...] (use TAB to see options)
# I really recommend viridis colors
# NOTE: with viridis you need to know if you variable is continious or categotical
# The video on viridis https://youtu.be/xAoljeRJ3lU

# paletteer !!!
library(paletteer)
# https://github.com/EmilHvitfeldt/r-color-palettes

df_sw <- swiss %>% clean_names()

df_sw %>%
    ggplot(aes(x = agriculture,
               y = fertility,
               color = education)) +
    geom_point()

crossing(
    x = LETTERS %>% extract(1:4),
    y = 5:8
) %>% 
    mutate(z = runif(16)) %>% 
    ggplot(aes(x, y, fill = z))+
    geom_tile()

gg <- ggplot2::last_plot()


gg +
    scale_fill_viridis_c("RANDOM", 
                         # begin = .2, end = .9,
                         option = "B")

ggd <- crossing(
    x = LETTERS %>% extract(1:4),
    y = 5:8
) %>% 
    mutate(
        z = runif(16) %>% 
            cut_width(1/4)
    ) %>% 
    ggplot(aes(x, y, fill = z))+
    geom_tile()


gg+
    scale_fill_distiller(palette =  "YlOrRd")


library(paletteer)

gg + scale_fill_paletteer_c("grDevices", "rainbow")



ggd + scale_fill_manual(values = c("#145bcc", "#990f49", "#a4e663", "yellow"))



crossing(
    x = LETTERS %>% extract(1:4),
    y = 5:8
) %>% 
    mutate(z = runif(16) %>% 
               cut(c(0, .2, .5, .8, 1)),
           col = sample(size = 16, 
                        c("black", "#990f49", "#a4e663", 
                          "yellow"), replace = T)) %>% 
    ggplot(aes(x, y, fill = col))+
    geom_tile()+
    scale_fill_identity()



# fonts -------------------------------------------------------------------

# library(extrafont)
library(hrbrthemes)
import_roboto_condensed()


gg + theme_minimal(base_family = font_rc)




# scale _ identity --------------------------------------------------------

# https://twitter.com/ikashnitsky/status/937786580231696384

n <- 1e2

tibble(x = runif(n),
       y = runif(n),
       size = runif(n, min = 4, max = 20)) %>%
    ggplot(aes(x, y, size = size)) +
    geom_point(color = "white", shape = 1) +
    scale_size_identity() +
    coord_cartesian(c(0, 1), c(0, 1)) +
    theme_void() +
    theme(
        panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black")
    )


# generate bubbles of random color and size
n <- sample(20:50, 1)

tibble(
    x = runif(n),
    y = runif(n),
    size = runif(n, min = 3, max = 20),
    color = rgb(runif(n), runif(n), runif(n))
) %>%
    ggplot(aes(x, y, size = size, color = color)) +
    geom_point() +
    scale_color_identity() +
    scale_size_identity() +
    coord_cartesian(c(0, 1), c(0, 1)) +
    theme_void()

