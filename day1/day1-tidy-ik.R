#===============================================================================
# 2019-07-08 -- BSSD dataviz
# Tidy data
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


# Reshaping data with tidyr -----------------------------------------------

# to wide format
pop_w <- spread(data = pop, key = year, value = value)

# equivalently we can start using the piping operator ( %>% )
pop_w <- pop %>% 
    spread(year, value)

# back to long format
pop_l <- pop_w %>% 
    gather(key = "year", value = "value", 
           4:9)


# Basic dplyr functions ---------------------------------------------------
library(magrittr)

# filter
pop_filt <- pop %>% 
    filter(year %>% equals('y2003'), sex!='b')

# select
pop_select <- pop %>% 
    select(2, 4)

# bind dfs
df_bind <- bind_rows(pop, deaths)


# join
df_joined <- left_join(deaths, pop, 
                       by = c("year", "region", "sex", "age")) 


# rename
df_re <- df_joined %>% 
    rename(deaths = value.x, pop = value.y)


# mutate 
df <- df_re %>% mutate(mx = deaths / pop)

# transmute as a shortcut for both rename and mutate (+select)
df_tr <- df_joined %>% 
    transmute(nuts2reg = region, 
              sex, age,
              time = year,
              mx = value.x / value.y)




# group %>% summarize %>% ungroup
df_sum <- pop %>% 
    # filter(sex != "b") %>% 
    group_by(region, sex, age) %>% 
    summarise(mean = mean(value),
              sum = value %>% sum) %>% 
    ungroup()


# summarise_if(is.numeric, ...)
df_sum_if <- pop %>% 
    spread(year, value) %>% 
    group_by(sex, age) %>% 
    summarise_if(.predicate = is.numeric, 
                 .funs = mean)


# now we save the data frame to be used in the ggplot show
df <- inner_join(deaths, pop, by = c('year',"region",'sex','age')) %>% 
    rename(deaths = value.x, pop = value.y) %>% 
    mutate(mx = deaths / pop)



# saving data in Rdata (rda) format ---------------------------------------

save(df, file = 'data/Denmark.Rdata')


# Erase all objects in memory
rm(list = ls(all = TRUE))

# load the result again
load("data/Denmark.Rdata")
