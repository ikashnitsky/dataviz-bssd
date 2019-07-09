#===============================================================================
# 2019-07-09 -- BSSD dataviz
# Population pyramid example
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================


# load the package
library(tidyverse)
library(readxl)

# read in Denmark population data
pop <- read_excel(
    path = 'data/data-denmark.xlsx', 
    sheet = 'pop'
)

# let's plot both sex population as histogram
# we'll use Copenhagen area (DK01)

pop %>% 
    filter(
        year == "y2005", region == "DK01",
        sex == "b", !age %in% c("open","total")
    ) %>% 
    ggplot(aes(age, value))+
    geom_col()


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
    geom_col()
    
    
# both sex, coord_flip    
    