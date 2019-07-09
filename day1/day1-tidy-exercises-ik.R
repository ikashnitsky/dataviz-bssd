#===============================================================================
# 2019-07-08 -- BSSD dataviz
# Tidy exercises
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================


# load the package
library(tidyverse)


# Read the data with readxl -----------------------------------------------

library(readxl)

# see the names of the sheets
readxl::excel_sheets('data/data-denmark.xlsx')

deaths <- read_excel(path = 'data/data-denmark.xlsx', sheet = 'deaths')
pop <- read_excel(path = 'data/data-denmark.xlsx', sheet = 'pop')



deaths %>% 
    mutate(age = age %>% str_replace("a", replacement = "") %>% 
               as.numeric())

deaths %>% 
    group_by(year) %>% 
    arrange(value %>% desc)


# Ex 1. deaths dataframe --------------------------------------------------

# - subset only total number of deaths among men in year 2003 (filter)
# Q: which region had the largest number of deaths?

deaths %>% 
    filter(age == "total", 
           sex == "m", 
           year == "y2003") %>% 
    arrange(value %>% desc)

# Ex 2. pop dataframe -----------------------------------------------------

# - subset only the year 2004
# - transform to wide format using the column "sex" (spread)
# - get rid of the column for both sex
# - calculate the sex ratio (males to females)
# Q: in which region the SR is highest at ages 15, 45, over75 (coded as "open")


df_sr <- pop %>% 
    filter(year == "y2004") %>%
    spread(sex, value) %>% 
    select(-b) %>% 
    mutate(sr = m/f)

df_sr %>% 
    filter(age %in% c("a15", "a45", "open")) %>% 
    arrange(sr %>% desc) %>% 
    group_by(year, age) %>% 
    filter(sr == sr %>% max) %>% View

df_sr %>% 
    filter(age %in% c("a15", "a45", "open")) %>% 
    group_by(year, age) %>% 
    arrange(sr %>% desc) %>% 
    top_n(1)

# Ex 3. joined dataframe --------------------------------------------------

# - join the two dataframes (left_join OR inner_join)
# - calculate age specific mortality ratios
# - subset only the ages 40-59 and year 2001
# Q: what is the average ratio of male ASMR to female ASMR in each region? 
# Tip: use summarize

left_join(
    deaths, pop, 
    by = c("year", "region", "sex", "age")
) %>% 
    transmute(
        year, region, sex, age, 
        mx = value.x / value.y
    ) %>% 
    filter(year == "y2001",
           age %in% paste0("a", 40:59),
           sex != "b") %>%
    spread(sex, mx) %>% 
    mutate(asmr = m / f) %>% 
    group_by(region) %>% 
    summarise(avg_asmr = asmr %>% mean(na.rm = T))


# Ex 4. joined dataframe (df) ---------------------------------------------

# - subset only both sex
# - transform to wide format using the column "year" (spread)
# - calculate the growth of ASMR between 2005 and 2001
# Q: in which region the average growth/decrease in ASMR was largest?

left_join(
    deaths, pop, 
    by = c("year", "region", "sex", "age")
) %>% 
    transmute(
        year, region, sex, age, 
        mx = value.x / value.y
    ) %>% 
    filter(sex == "b", age != "total") %>% 
    spread(year, mx) %>% 
    transmute(region, age,
              growth = y2005 - y2001) %>% 
    group_by(region) %>% 
    summarise(avg_growth = growth %>% mean) %>% 
    arrange(avg_growth)

