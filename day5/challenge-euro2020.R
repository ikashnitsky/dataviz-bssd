#===============================================================================
# 2021-07-16 -- BSSD dataviz
# Dataviz challenge -- EURO 2020 data
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# Dataset is a detailed team squads data from Transfermarkt
# https://www.transfermarkt.com/euro-2020/teilnehmer/pokalwettbewerb/EM20
# For each country it looks like this
# https://www.transfermarkt.com/england/startseite/verein/3299

library(tidyverse)
library(magrittr)

# load the dataset
source("https://gist.githubusercontent.com/ikashnitsky/5f305b91aacd5ea61dbd64a2f938773d/raw/a3eb3d280946023cd66601de100482a36b144d6c/euro_2020_players.R")

# check the dataset
euro_2020_players %>% print()

# # consider
# euro_2020_players %>% xray::distributions()

# Have fun!

# Link to submit your output
# https://docs.google.com/forms/d/e/1FAIpQLSdWaJZLhstdyyUlz1GzcneQvZa5C2D7Ib7C0dlAKvm0klEEmw/viewform
