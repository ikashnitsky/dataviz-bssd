#===============================================================================
# 2019-07-12 -- BSSD dataviz
# Dataviz challenge
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load required packages
library(tidyverse)
library(janitor)
library(sf)
library(lubridate)
library(magrittr)


# the data
ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")

# clean up a bit
df <- ufo_sightings %>% 
    mutate(
        date_time = date_time %>% parse_date_time('mdy_HM'),
        month = date_time %>% month(label = TRUE) %>% as.factor(),
        year = date_time %>% year(),
        day = date_time %>% day(),
        week = date_time %>% week(),
        wday = date_time %>% wday(week_start = 1, label = TRUE),
        date_documented = date_documented %>% parse_date_time('mdy'),
        gap_doc = as.duration(date_documented - date_time) / 
            as.duration(years(1))
    )

# calculate population weighted rates -------------------------------------


devtools::install_github("nsgrantham/uspops")

library(uspops) # population counts
library(tigris) # for spatial data

us_geo <- 
    tigris::states(
        class = "sf", 
        cb = TRUE, 
        resolution = "20m" # this parameter gives us a lightweight sf
        # with rough borgers; will be faster to plot
    ) %>% 
    clean_names() %>% 
    inner_join(
        state_pops %>% # this comes from {uspops}
            filter(year == 2018),
        by = c("name" = "state")
    ) %>% 
    filter(!stusps %in% c("AK", "HI", "PR")) %>% # lazy but here we are
    mutate(state = stusps %>% tolower)

# test map
us_geo %>% 
    ggplot()+
    geom_sf(aes(fill = pop))


# join the dataset
ufo_us <- df %>% 
    filter(country == "us") %>% 
    # mind how you aggregate cases 
    group_by(state, year) %>% 
    summarise(cases = n()) %>% 
    ungroup() %>% 
    inner_join(us_geo, "state") %>% 
    mutate(rate = cases / pop)


# this is an attempt to plot points; it takes forever on my machine   
gd_point <- df %>% 
    filter(country == "us",
           !state %in% c("ak", "hi", "pr")) %>% 
    st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

us_geo %>% 
    ggplot()+
    geom_sf(aes(fill = pop))+
    geom_sf(data = gd_point)


# now let's produce the map with UFO sight aggregated over the whole period and weighted by population size of the states
df %>% 
    filter(country == "us") %>% 
    # mind how you aggregate cases 
    group_by(state) %>% # omit year to aggregate by states
    summarise(cases = n()) %>% 
    ungroup() %>% 
    left_join(us_geo, ., "state") %>% 
    st_transform(crs = 2163) %>% # LAEA projection for the US
    mutate(rate = cases / pop) %>% # !!! here we calc the rate
    ggplot()+
    geom_sf(aes(fill = rate))+
    scale_fill_viridis_c()+
    coord_sf(datum = NA)+
    theme_void()


# below goes my exploration of the hypothesed relationship between the reporting time gap and the reported duration of the encounter. Interesting tool to pick up here is the way one can use faceting for sensitivity analysis fitting regression to the subgroups of the data; pretty cheap exploratory solution

 # plot --------------------------------------------------------------------
    
df %>% 
    filter(
        encounter_length %>% is_weakly_greater_than(1),
        encounter_length %>% is_less_than(144e3),
        gap_doc %>% is_weakly_less_than(50)
    ) %>%
    drop_na(gap_doc, encounter_length) %>% 
    ggplot(aes(
        x = gap_doc, 
        y = encounter_length
    ))+
    geom_point(alpha = .01, shape = 21, stroke = NA, fill = "black")+
    stat_smooth(method = "lm")+
    scale_y_continuous(
        trans = "log", # note the log scale
        breaks = c(0, 1, 5, 10, 30, 60, 600, 1800, 3600, 18000, 72000),
        labels = c("", paste0(c(1,5,10,30), "sec"), 
                   paste0(c(1,10,30), "min"), "1 hour", "5 hours", "20 hours")
    )+
    scale_x_continuous(
        trans = "log", # and here
        breaks = c(1, 5, 10, 25, 50, 100),
        labels = c(1, 5, 10, 25, 50, 100)
    )+
    theme(panel.grid.minor = element_blank())+
    labs(x = "Years between observed and recorded", 
         y = "Length of UFO observation")

gg <- last_plot()


# here I cut both axes in three categories and plot small multiples
gg +
    facet_grid(
        encounter_length %>% cut(c(0, 60, 1800, Inf)) %>% fct_rev() ~ 
            gap_doc %>% cut(c(0, 1, 25, Inf)),
        scales = "free"
    )

# only cut encounter_length in three
gg +
    facet_wrap(
        ~ encounter_length %>% cut(c(0, 60, 1800, Inf)),
        scales = "free"
    )

# cut separately the gap measure in three
gg + 
    facet_wrap(
    ~ gap_doc %>% cut(c(0, 1, 25, Inf)),
    scales = "free",
    ncol = 4
)

# cut in more subgroups
gg + 
    facet_wrap(
        ~ gap_doc %>% cut(c(0, .2, 1, 10, 25, Inf)),
        scales = "free",
        nrow = 1
    )

# 
gg +
    facet_grid(
        encounter_length %>% cut(c(0, 60, 1800, Inf)) %>% fct_rev() ~ 
            gap_doc %>% cut(c(0, 1/12, 1, 10, 25, Inf)),
        scales = "free"
    )

# by country
gg +
    facet_wrap(~country, scales = "free", nrow = 2)

# check the simpklest linear regression
with(df, lm(encounter_length ~ gap_doc)) %>% summary


# boxplots
df %>% 
    drop_na(gap_doc, encounter_length) %>% 
    ggplot(aes(
        x = gap_doc %>% cut_width(2, boundary = 1), 
        y = encounter_length %>% log()
    ))+
    geom_boxplot()


# CALENDAR PLOT -----------------------------------------------------------

# calendar plot of death tolls by day

library(hrbrthemes); import_roboto_condensed()

df %>% 
    filter(year %in% 2000:2013) %>% 
    group_by(year, day) %>% 
    mutate(cases = n()) %>% 
    ggplot(aes(week, wday, fill = cases))+
    geom_tile()+
    scale_fill_viridis_c("# UFO\nsightings\nper day",option = "B")+
    scale_x_continuous(breaks = c(1:9, 20, 30, 52))+
    facet_grid(year~month, scales = "free")+
    theme_minimal(base_family = font_rc)+
    theme(panel.grid = element_blank())+
    labs(x = "week of the year", y = NULL,
         title = "Numbers of reported UFO sightings in the World",
         caption = "Data: The National UFO Reporting Center; tidytuesday\nhttps://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")+
    theme(axis.text.y = element_text(size = 7),
          plot.title = element_text(size = 30, face = 2))

ggsave("ufo-calendar.pdf", width = 10, height = 10, device = cairo_pdf)

