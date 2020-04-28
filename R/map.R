library(tidyverse)
library(sf)
library(BelgiumMaps.StatBel)
library(leaflet)
library(htmltools)
library(tmap)
library(tmaptools)



scuba <- read.csv("./data/logbook_data.csv",
  na = "")
# Extract coordinates
coords_scuba <-
  scuba %>%
  select(decimalLongitude, decimalLatitude)
# Transfomr obs_butterflies to a sf data.frame (data in WGS84)
scuba <-
  st_as_sf(scuba,
           coords = c("decimalLongitude", "decimalLatitude"),
           crs = 4326)
# Add coordinates as two extra columns
scuba <-
  scuba %>%
  bind_cols(coords_scuba)

# Double check the Coordinate Reference System (CRS)
st_crs(scuba)

m <- leaflet(data = scuba) %>% setView(lng = -2 , lat = 37, zoom = 7)
m %>% addTiles() %>% addMarkers(~decimalLongitude,
                                ~decimalLatitude,
                                popup = ~as.character(paste0("Date: ",eventDate)),
                                label = ~as.character(paste0("Locality: ", locality)),
                                clusterOptions = markerClusterOptions())
