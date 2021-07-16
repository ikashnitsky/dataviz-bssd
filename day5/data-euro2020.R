#===============================================================================
# 2021-07-16 -- BSSD dataviz
# Dataviz challenge -- prepare EURO 2020 data
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

library(tidyverse)
library(magrittr)
library(rvest)
library(countrycode)

# Get the detailed team squads data from Transfermarkt 
# https://www.transfermarkt.com/euro-2020/teilnehmer/pokalwettbewerb/EM20

# try make it work for one country
page <- read_html("https://www.transfermarkt.com/england/startseite/verein/3299")

table <- html_nodes(page, "table") %>% #list all tables
  extract2(., str_which(. ,"Age")) %>% # select the one needed
  html_table(fill = T) %>%  # convert to a table
  set_names(letters[1:9]) %>% 
  transmute(
    no = a, 
    position = e,
    name = f,
    age = g,
    market_value = i %>% str_extract("[0-9]+")
  ) %>% 
  drop_na()

# did it work?
table %>% view

# a function too process them in a batch
get_team <- function(url){
  
  cntr <- url %>% 
    str_remove_all("[0-9]+") %>% 
    str_remove("https://www.transfermarkt.com/") %>% 
    str_remove("/startseite/verein/")
    
  page <- read_html(url)
  
  table <- html_nodes(page, "table") %>% #list all tables
    extract2(., str_which(. ,"Age")) %>% # select the one needed
    html_table(fill = T) %>%  # convert to a table
    set_names(letters[1:9]) %>% 
    transmute(
      country = cntr,
      no = a %>% paste, 
      position = e,
      name = f,
      age = g,
      market_value = i %>% str_extract("[0-9]+") %>% as.numeric()
    ) %>% 
    drop_na()
}

# check
"https://www.transfermarkt.com/england/startseite/verein/3299" %>% get_team %>% view


links <- c(
  "https://www.transfermarkt.com/england/startseite/verein/3299",
  "https://www.transfermarkt.com/frankreich/startseite/verein/3377",
  "https://www.transfermarkt.com/deutschland/startseite/verein/3262",
  "https://www.transfermarkt.com/spanien/startseite/verein/3375",
  "https://www.transfermarkt.com/portugal/startseite/verein/3300",
  "https://www.transfermarkt.com/italien/startseite/verein/3376",
  "https://www.transfermarkt.com/belgien/startseite/verein/3382",
  "https://www.transfermarkt.com/niederlande/startseite/verein/3379",
  "https://www.transfermarkt.com/kroatien/startseite/verein/3556",
  "https://www.transfermarkt.com/turkei/startseite/verein/3381",
  "https://www.transfermarkt.com/osterreich/startseite/verein/3383",
  "https://www.transfermarkt.com/danemark/startseite/verein/3436",
  "https://www.transfermarkt.com/schweiz/startseite/verein/3384",
  "https://www.transfermarkt.com/schottland/startseite/verein/3380",
  "https://www.transfermarkt.com/polen/startseite/verein/3442",
  "https://www.transfermarkt.com/schweden/startseite/verein/3557",
  "https://www.transfermarkt.com/ukraine/startseite/verein/3699",
  "https://www.transfermarkt.com/russland/startseite/verein/3448",
  "https://www.transfermarkt.com/tschechien/startseite/verein/3445",
  "https://www.transfermarkt.com/wales/startseite/verein/3864",
  "https://www.transfermarkt.com/slowakei/startseite/verein/3503",
  "https://www.transfermarkt.com/ungarn/startseite/verein/3468",
  "https://www.transfermarkt.com/nordmazedonien/startseite/verein/5148",
  "https://www.transfermarkt.com/finnland/startseite/verein/3443"
)


raw <- links %>% map_df(get_team)

# Good idea to save the raw scraped data 
# save(raw, file = "your-path/raw-data.rda")

save(raw, file = "2106-rostock-retreat/dat/euro-2020-raw.rda")

euro_2020_players <- raw %>% 
  mutate(
    # fix market_value in thousands
    market_value = case_when(
      market_value %>% is_greater_than(160) ~ market_value %>% divide_by(1000),
      TRUE ~ market_value
    ),
    # fix country names 
    cntr = country %>% 
      str_to_title %>% 
      countrycode(origin = "country.name.de",destination = "country.name"),
    cntr = case_when(
      country == "schottland" ~ "Scotland",
      country == "turkei" ~ "Turkey",
      country == "england" ~ "England",
      country == "wales" ~ "Wales",
      TRUE ~ cntr
      )
  ) %>% 
  group_by(cntr) %>% 
  mutate(
    avg_age = age %>% mean,
    avg_age_mv = weighted.mean(age, market_value)
  ) %>% 
  ungroup() %>% 
  mutate(cntr = cntr %>% as_factor %>% fct_reorder(avg_age))

save(euro_2020_players, file = "2106-rostock-retreat/dat/euro-2020.rda")



# visualizatiions ---------------------------------------------------------


# plot
euro_2020_players %>% 
  ggplot(aes(age, cntr, group = cntr))+
  geom_point(aes(size = market_value), color = 8)+
  geom_boxplot(fill = NA, notch = T, notchwidth = .2, 
               outlier.alpha = 0, color = "#222222")+
  stat_summary(fun = mean, geom = "point", color = 2, shape = 43, size = 5)+
  geom_point(data = . %>% select(cntr, avg_age_mv) %>% distinct(),
             aes(x = avg_age_mv), color = 4, shape = 124, size = 5)+
  scale_size_area()+
  scale_x_continuous(position = "top")+
  theme(legend.position = "bottom")+
  labs(
    x = "Age",
    y = NULL,
    size = "Value, m€"
  )


euro_2020_players %>% 
  ggplot(aes(market_value, cntr %>% fct_reorder(market_value), group = cntr))+
  geom_point(aes(size = market_value), color = 8)+
  geom_boxplot(fill = NA, notch = T, notchwidth = .2, 
               outlier.alpha = 0, color = "#222222")+
  # stat_summary(fun = mean, geom = "point", color = 2, shape = 43, size = 5)+
  # geom_point(data = . %>% select(cntr, avg_age_mv) %>% distinct(),
  #            aes(x = avg_age_mv), color = 4, shape = 124, size = 5)+
  scale_size_area()+
  scale_x_continuous(position = "top")+
  theme(legend.position = "bottom")+
  labs(
    x = "Market Value",
    y = NULL,
    size = "Value, m€"
  )
