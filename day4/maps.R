# ..........................................................
# 2025-07-17 -- BSSD dataviz
# Maps                                           -----------
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
# ..........................................................

# load required packages
library(tidyverse)
library(magrittr)
library(sf)
library(cowplot)

# read local shapefile ----------------------------------------------------

# read in the shapefile as sf object
gd_fr <- read_sf("data/shape-france.shp")

# base R plotting method
gd_fr |> plot()

# minimal ggplot
gd_fr |>
  ggplot() +
  geom_sf()

# reproject
gd_fr |>
  ggplot() +
  geom_sf() +
  coord_sf(crs = 2154)

# LAEA -- appropriate European proj
gd_fr |>
  ggplot() +
  geom_sf() +
  coord_sf(crs = 3035, datum = NA) +
  theme_map()


# eurostat package --------------------------------------------------------

library(eurostat)

# the built-in dataset of EU boundaries
gd <- eurostat_geodata_60_2016 |>
  janitor::clean_names()

# let's build the most basic map
gd |>
  ggplot() +
  geom_sf()

# transform the projection for the one suitable for Europe
gdtr <- gd |>
  st_transform(crs = 3035)

gdtr |>
  ggplot() +
  geom_sf()

# Further on, I will run all the examples for Italy only, for the speed of code execution

# filter out Italy
gd_it <- gdtr |>
  filter(cntr_code == "IT", levl_code == 3)

# the basic map
gd_it |>
  ggplot() +
  geom_sf()

# get rid of the grid
gd_it |>
  ggplot() +
  geom_sf() +
  coord_sf(datum = NA)


# datum parameter controls the grid
# if we set it to the projection being used we can see the axes in meters
gd_it |>
  ggplot() +
  geom_sf() +
  coord_sf(datum = st_crs(3035))


# these maps are simple ggplots, so we can change them like any other plot
# {cowplot} package contains a nice theme for maps
gd_it |>
  ggplot() +
  geom_sf() +
  coord_sf(datum = NA) +
  theme_map()


# get eurostat data -------------------------------------------------------

# there is quite a useful cheatsheet for the package
# http://ropengov.github.io/eurostat/articles/cheatsheet.html

# let's try to search
search_eurostat("life expectancy") |> view()

# Not nearly as cool as we'd like
# better go to
# http://ec.europa.eu/eurostat/data/database
# OR
# https://ec.europa.eu/eurostat/web/regions/database

# download the dataset found manually
df <- get_eurostat("demo_r_find3") |>
  janitor::clean_names()

# if the automated download does not work, the data can be grabbed manually at
# https://ec.europa.eu/eurostat/databrowser/bulk?lang=en

# time series length
df$time_period |> unique()

# ages
df$indic_de |> unique()

# now we filter out TFR for Italian regions, NUTS3 only, let's keep all the years for now
df_it <- df |>
  filter(
    indic_de == "TOTFERRT",
    geo |> str_sub(1, 2) == "IT", # only Italy
    geo |> paste() |> nchar() == 5 # only NUTS-3
  ) |>
  transmute(
    id = geo |> paste(),
    year = time_period |> year(),
    tfr = values
  )

# the last thing is to join stat and spatial datasets
dj_it <- left_join(gd_it, df_it, "id")


# plot TFR
dj_it |>
  ggplot() +
  geom_sf(aes(fill = tfr)) +
  coord_sf(datum = NA) +
  theme_map()


# now let's use viridis colors
dj_it |>
  ggplot() +
  geom_sf(aes(fill = tfr)) +
  scale_fill_viridis_c(option = "B") +
  coord_sf(datum = NA) +
  theme_map() +
  theme(legend.position = c(.9, .6)) +
  labs(fill = "TFR")

# something's wrong, isn't it?
# where is the lowest observed value (black)?

# ...

# It's observed in one of the previous years!
dj_it |>
  ggplot() +
  geom_sf(aes(fill = tfr)) +
  scale_fill_viridis_c(option = "B") +
  coord_sf(datum = NA) +
  theme_map() +
  # theme(legend.position = c(.9, .6))+
  labs(fill = "TFR") +
  facet_wrap(~year, ncol = 5)


# next we'll use just 2017 and save for plotly
dj_it |>
  filter(year == 2017) |>
  ggplot() +
  geom_sf(aes(fill = tfr), color = NA) +
  scale_fill_viridis_c(option = "B") +
  coord_sf(datum = NA) +
  theme_map() +
  theme(legend.position = c(.9, .6)) +
  labs(fill = "TFR")


# save
p <- ggplot2::last_plot()


# A bit of magic: interactive plots with PLOTLY ---------------------------

library(plotly)

# let's create a basic plot
q <- qplot(data = mtcars, hp, mpg, color = cyl |> factor())
q
# now, magic
ggplotly(q)


# let's try with maps
ggplotly(p) # doesn't work for me


dj_it |>
  filter(year == 2017) |>
  plot_ly() |>
  add_sf(
    split = ~id, # group by our regions
    alpha = 1, # non-transparent colors
    stroke = I("#ebebeb"), # color of the boundaries
    span = I(.1), # thickness of the boundaries
    color = ~tfr, # the variable defining colors
    text = ~ paste(
      "Region:",
      id,
      "\n",
      "TFR:",
      tfr
    ), # hover box info
    hoveron = "fills",
    hoverinfo = "text",
    showlegend = FALSE # try TRUE to see what happens
  )


pl <- plotly::last_plot()

htmlwidgets::saveWidget(pl, "out/ggplotly.html")


# bonus -- animate changes from year to year
dj_it |>
  plot_ly(
    frame = ~year
  ) |>
  add_sf(
    split = ~id, # group by our regions
    alpha = 1, # non-transparent colors
    stroke = I("#ebebeb"), # color of the boundaries
    span = I(.1), # thickness of the boundaries
    color = ~tfr, # the variable defining colors
    text = ~ paste(
      "Region:",
      id,
      "\n",
      "TFR:",
      tfr
    ), # hover box info
    hoveron = "fills",
    hoverinfo = "text",
    showlegend = FALSE # try TRUE to see what happens
  )

# unload {plotly} # explain last_plot()
pacman::p_unload(plotly)

# create inner boundaries as lines ---------------------------------------

library(rmapshaper)

bord <- gdtr |>
  filter(cntr_code == "IT", levl_code == 2) |>
  ms_innerlines()


# now add them to the map
dj_it |>
  filter(year == 2017) |>
  ggplot() +
  geom_sf(aes(fill = tfr), color = NA) +
  geom_sf(data = bord, color = "gray92") +
  scale_fill_viridis_c(option = "B") +
  coord_sf(datum = NA) +
  theme_map() +
  theme(legend.position = c(.9, .6)) +
  labs(fill = "TFR")


# simplifying polygons ----------------------------------------------------
dj_it |>
  filter(year == 2017) |>
  ms_simplify() |> #!!!
  ggplot() +
  geom_sf(aes(fill = tfr), color = NA) +
  geom_sf(data = bord, color = "gray92") +
  scale_fill_viridis_c(option = "B") +
  coord_sf(datum = NA) +
  theme_map() +
  theme(legend.position = c(.9, .6)) +
  labs(fill = "TFR")


# cities ------------------------------------------------------------------

# package maps contains a nice dataset of world cities
library(maps)

world.cities |> view()

# subset Italian cities
it_cit <- world.cities |>
  dplyr::filter(
    country.etc == "Italy",
    # let's take only cities bigger than 100K
    pop > 1e5
  ) |>
  st_as_sf(
    coords = c("long", "lat"),
    crs = 4326
  )

# add to the map
p + geom_sf(data = it_cit)


# geodata ---------------------------------------------------------------

# This is a beautiful package to streamline download of open geodata from many providers. We will use GADM for boundaries

library(geodata)

gadm_it <- gadm(country = "ITA", level = 1, path = "~/data/geodata") |>
  st_as_sf()

gadm_it |>
  ggplot() +
  geom_sf()

gadm_it |>
  ms_simplify() |> # the init file took forever for me to render so I simplify
  ggplot() +
  geom_sf()


# geocoded points ---------------------------------------------------------

# Kazakh GGP data

kz_raw <- rio::import(here::here("data/unmet_loc.csv"))

library(xray)

kz_raw |> xray::distributions()

kz_clean <- kz_raw |>
  rename(x = Longitude, y = Latitude) |>
  drop_na(x, y) |>
  st_as_sf(
    coords = c("x", "y"),
    crs = 4326
  )


# regions
gd_kz <- gadm(country = "KAZ", level = 1, path = "~/data/geodata") |>
  st_as_sf()

gd_kz |>
  ms_dissolve(field = "NAME_1") |>
  ms_simplify() |>
  ggplot() +
  geom_sf() +
  geom_sf(data = kz_clean, color = 2, alpha = .05)

# limit points to KZ only
kz_only <- kz_clean |>
  ms_clip(clip = gd_kz)

gd_kz |>
  ms_dissolve(field = "NAME_1") |>
  ms_simplify() |>
  ggplot() +
  geom_sf() +
  geom_sf(data = kz_only, color = 2, alpha = .05)


gd_kz |>
  ms_dissolve(field = "NAME_1") |>
  ms_simplify() |>
  ggplot() +
  geom_sf() +
  geom_sf(data = kz_only, color = 2, alpha = .05) +
  facet_wrap(~unmet)


# interactive map with leaflet
library(leaflet)

leaflet(gd_kz) |>
  setView(100, 50, 2) |>
  addProviderTiles(providers$Stamen.Toner) |>
  addCircleMarkers(
    kz_raw$Longitude,
    kz_raw$Latitude,
    radius = 1,
    color = 2,
    popup = kz_clean$unmet,
    label = kz_clean$unmet
  )
