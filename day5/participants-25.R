# ..........................................................
# 2025-07-18 -- BSSD dataviz
# Randomly assign participants & teams         -----------
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
# ..........................................................

# countries for the day4 assignment ---------------------------------------

library(tidyverse)

here_we_are <- c(
  "Maria",
  "Tere",
  "Jasmine",
  "Rita", 
  "Barbara",
  "Anna"
)

# select 15 largest EU countries by the number of NUTS-3 regions
largest_eu_countries <-
  eurostat::eurostat_geodata_60_2016 |>
  janitor::clean_names() |>
  filter(levl_code == 3) |>
  mutate(cntr = nuts_id |> str_sub(1, 2)) |>
  group_by(cntr) |>
  summarise(n_units = n()) |>
  arrange(n_units |> desc()) |>
  pull(cntr) |>
  head(6)


# randomly assign
set.seed(17)

tibble(
  here_we_are,
  largest_eu_countries |> sample(6)
) |>
  view()


# assign participants to teams for the challenge --------------------------

# # The online team:
# online_participants <- c(
#   "Joanna",
#   "Olga",
# )
# 
# 
# set.seed(719)
# 
# # In-class teams:
# offline_participants <-
#   tibble(
#     participant = here_we_are
#   ) |>
#   # remove online participants
#   filter(
#     !participant %in% online_participants
#   ) |>
#   # assign teams randomly
#   mutate(
#     team = sample(
#       LETTERS[1:3],
#       size = n(),
#       replace = T
#     )
#   )
# 
# 
# offline_participants %>% view()
