library(tidyverse)
library(sf) # for working with special feature
library(leaflet) # for working with maps
library(htmltools) # for working with html labels
library(tmap)
library(tmaptools)
library(googlesheets4)
library(lubridate) # for working with dates
library(ggplot2)  # for creating graphs
library(scales)   # to access breaks/formatting functions
library(gridExtra) # for arranging plots
library(ggthemes) # for ggplot themes
library(dplyr)


# Logbook in google sheets
data <- "1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # Turn into a funtion # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#logbook_map <- function (data){

### READ DATA
#-------------

# From Google sheets
(scuba_log <- read_sheet(data, sheet = 1, na = ""))

# From working directory
# scuba <- read.csv("./data/logbook_data.csv", na = "")

#.........................................................



### DATA PROCESSING
#--------------------

## Preparation for Leaflet:

# Remove records with no coordinates to prepare dataset for map
scuba_clean <- scuba_log %>% filter (!is.na(decimalLatitude) & !is.na(decimalLatitude))

# Some columns need a special data type. eventDate needs to be character to be good as a label
scuba_clean$decimalLatitude <- as.numeric(scuba_clean$decimalLatitude)
scuba_clean$decimalLongitude <- as.numeric(scuba_clean$decimalLongitude)
scuba_clean$eventDate <- as.character(scuba_clean$eventDate)
scuba_clean$maximumDepthInMeters <- as.character(scuba_clean$maximumDepthInMeters)
scuba_clean$bottomTime <- as.character(scuba_clean$bottomTime)

# Remove NA's introduced by coercion (actually we should fix them in the original table)
# scuba_clean <- scuba_clean %>% filter (!is.na(decimalLatitude) & !is.na(decimalLatitude))


# Extract coordinates
coords_scuba <-
  scuba_clean %>%
  select(decimalLongitude, decimalLatitude)

# Transform scuba_map to a sf data.frame (data in WGS84)
scuba_map <-
  st_as_sf(scuba_clean,
           coords = c("decimalLongitude", "decimalLatitude"),
           crs = 4326)
# Add coordinates as two extra columns
scuba_map <-
  scuba_map %>%
  bind_cols(coords_scuba)

# Double check the Coordinate Reference System (CRS)
st_crs(scuba_map)

#.........................................................



### MAKING MAP
#--------------------

# Labels use scuba_clean because it is not an sf object

labs <- lapply(seq(nrow(scuba_clean)), function(i) {
  paste0('<p>', '<b> <font size = 3> Dive Log </font> </b>' ,'</p>',
          '<p>', '<b> Date: </b>' ,scuba_clean[i, "eventDate"], '</p>', 
          '<b> Divesite: </b>', scuba_clean[i, "locationID"], ', ', 
          scuba_clean[i, "locality"],'</p><p>', 
          '<b> Max Depth: </b>',  scuba_clean[i, "maximumDepthInMeters"], ' metres', '</p><p>',
          '<b> Bottom Time: </b>',  scuba_clean[i, "bottomTime"], ' minutes', '</p>') 
})


# Leaflet uses scuba_map because it is an sf object

m <- leaflet(data = scuba_map)


m %>% addProviderTiles('Esri.WorldImagery') %>% # can also try CartoDB.VoyagerOnlyLabels OR CartoDB.PositronOnlyLabels in next line
      addProviderTiles("CartoDB.DarkMatterOnlyLabels") %>% addMarkers(~as.numeric(decimalLongitude),
                                                          ~as.numeric(decimalLatitude),
                                                          popup = ~as.character(paste0("Dive type: ", diveType_1,
                                                                                       ifelse(is.na(diveType_2), "", paste0(" - ", diveType_2)),
                                                                                       ifelse(is.na(diveType_3), "", paste0(" - ", diveType_3)))),
                                                          popupOptions = popupOptions(), # Change size, opacity, etc
                                                          label = lapply(labs, htmltools::HTML),
                                                          labelOptions = labelOptions(direction = "left",
                                                                                      opacity = 0.9,
                                                                                      style = list(
                                                                                        "font-style" = "italic",
                                                                                        "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                                                                        "font-size" = "14px",
                                                                                        "border-color" = "rgba(0,0,0,0.5)"
                                                                                      )),
                                                          clusterOptions = markerClusterOptions()
                                                          )

#}


#logbook_map("1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M")










