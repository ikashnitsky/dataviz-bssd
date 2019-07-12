#===============================================================================
# 2019-07-12 -- BSSD dataviz
# Dataviz challenge
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load required packages
library(tidyverse)
library(magrittr)
library(sf)
library(lubridate)

# the data
df <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv") %>% 
    mutate(
        date_time = date_time %>% parse_date_time('mdy_HM'),
        month = date_time %>% month(label = TRUE) %>% as.factor(),
        year = date_time %>% year(),
        date_documented = date_documented %>% parse_date_time('mdy')
    )


# calculate population weighted rates -------------------------------------


devtools::install_github("nsgrantham/uspops")

library(uspops)
library(tigris)

us_geo <- tigris::states(class = "sf", cb = TRUE, resolution = "20m") %>% 
    clean_names() %>% 
    inner_join(
        state_pops %>% 
            # mutate(state = state %>% tolower) %>% 
            filter(year == 2018),
        by = c("name" = "state")
    ) %>% 
    filter(!stusps %in% c("AK", "HI", "PR")) %>% 
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