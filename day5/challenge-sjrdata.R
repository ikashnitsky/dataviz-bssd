#===============================================================================
# 2024-07-24 -- BSSD dataviz
# Dataviz challenge -- sjrdata
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# SCImago Journal & Country Rank provides valuable estimates of academic journals' prestige. The data is freely available at https://www.scimagojr.com
# I wrote a minimalist package to have their data easily accessible in R: https://github.com/ikashnitsky/sjrdata 


library(tidyverse)
library(magrittr)
# # if needed uncomment (crtl/cmd + SHIFT + C) & run
# remotes::install_github("ikashnitsky/sjrdata") 
library(sjrdata)

# load the dataset
df <- sjr_journals

# I also added a more detailed Scopus categorization of scientific fields
asjc <- readxl::read_xlsx("data/scopus-asjc-codes.xlsx")

# how to join the two provided datasets
df_joined <- df |> 
    separate_rows(categories, sep = "; ") |> 
    mutate(
        categories = categories |> str_remove_all(" \\s*\\([^\\)]+\\)")
    ) |> 
    left_join(asjc, c("categories" = "field")) 

# Link to submit your output
# https://bit.ly/bssd22-challenge
