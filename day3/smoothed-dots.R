#===============================================================================
# 2022-07-20 -- BSSD dataviz
# smoothed dots
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com, @ikashnitsky
#===============================================================================

# Zarulli V, Kashnitsky I, Vaupel JW. 2021. Death rates at specific life stages mold the sex gap in life expectancy. Proceedings of the National Academy of Sciences 118 DOI: 10.1073/pnas.2010588118

# https://github.com/ikashnitsky/sex-gap-e0-pnas

# twitter.com/ikashnitsky/status/1391859895264231431

library(tidyverse)
library(magrittr)

df_aq <- airquality %>%
    janitor::clean_names() %>%
    mutate(
        date = paste(day, month, "1973", sep = "-") %>%  
            lubridate::dmy(),
        month = month %>% factor
    )

df_aq %>%
    ggplot(aes(x = date, y = temp, color = month)) +
    geom_line()

df_aq %>%
    ggplot(aes(x = date, y = temp, color = month)) +
    geom_point()+
    geom_line(size = 2, alpha = .3)

df_aq %>%
    ggplot(aes(x = date, y = temp, color = month)) +
    geom_point()+
    geom_smooth(se = F)

# The one we are going to replicate
# https://twitter.com/ikashnitsky/status/1527024793136111616

