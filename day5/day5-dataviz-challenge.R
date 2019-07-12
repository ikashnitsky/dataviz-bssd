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