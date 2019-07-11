#===============================================================================
# 2019-07-09 -- BSSD dataviz
# Maps
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load required packages
library(tidyverse)
library(janitor)
library(sf)


# read local shapefile ----------------------------------------------------

# read in the shapefile as sf object
gd_fr <- read_sf("data/shape-france.shp")

gd_fr %>% 
        ggplot()+
        geom_sf()

# reproject
gd_fr %>% 
        ggplot()+
        geom_sf()+
        coord_sf(crs = 2154)


gd_fr %>% 
        ggplot()+
        geom_sf()+
        coord_sf(crs = 3035)



# eurostat package --------------------------------------------------------


library(eurostat)

# the built-in dataset of EU boundaries
gd_eu <- eurostat_geodata_60_2016 %>% 
        clean_names()

gd_eu %>% 
        filter(cntr_code == "IT", levl_code == 3) %>% 
        st_transform(crs = 3035) %>%
        ggplot()+
        geom_sf()


# get eurostat data -------------------------------------------------------

# there is quite a useful cheatsheet for the package
# http://ropengov.github.io/eurostat/articles/cheatsheet.html

# let's try to search
search_eurostat("life expectancy") %>% View

# Not nearly as cool as we'd like
# better go to 
# http://ec.europa.eu/eurostat/data/database
# OR
# http://ec.europa.eu/eurostat/web/regions/data/database

# download the dataset found manually
df <- get_eurostat("demo_r_find3")

# if the automated download does not work, the data can be grabbed manually at
# http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing

# time series length
df$time %>% unique()

# ages
df$indic_de %>% unique()

df %>% 
    spread(indic_de, values) %>% 
    filter(time == "2017-01-01") %>% 
    inner_join(gd_eu, c("geo" ="id")) %>% 
    ggplot() + geom_sf(aes(fill = TOTFERRT))



# create inner boundaries as lines ---------------------------------------

library(rmapshaper)

ms_innerlines()



# A bit of magic: interactive plots with PLOTLY ---------------------------

library(plotly)

# let's create a basic plot
q <- qplot(data = mtcars, hp, mpg, color = cyl %>% factor)
q
# now, magic
ggplotly(q)


# let's try with maps
gg <- 
gg

ggplotly(gg)

pl <- ggplotly(gg)
htmlwidgets::saveWidget(pl, "ggplotly.html")


# cities ------------------------------------------------------------------

library(maps)
india.cities <- world.cities %>% 
    dplyr::filter(country.etc=="Italy", pop > 1e5)


# GADMTools ---------------------------------------------------------------

# https://cran.r-project.org/web/packages/GADMTools/vignettes/Using_GADMTools.pdf
library(GADMTools)

gd_ken <- gadm.loadCountries(fileNames = "KEN", basefile = "./") # didn't work today


gd_ken <- readRDS(
        url("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_KEN_0_sf.rds")
)

# own simple function
get_gadm_sf <- function (country_iso, level = 0) {
        require(readr)
        the_url <- url(
                paste(
                        "https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36",
                        country_iso, 
                        level,
                        "sf.rds",
                        sep = "_"
                )
        )
        
        read_rds(the_url)
}


gd_it <- get_gadm_sf("ITA", 1)
