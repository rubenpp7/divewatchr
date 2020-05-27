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
logbook <- "1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M"




load_data <- function (data){

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
  scuba_map <- scuba_map %>%
  bind_cols(coords_scuba)

# Double check the Coordinate Reference System (CRS)
print(st_crs(scuba_map))

# Return list with wanted objects
x <- list(scuba_map = scuba_map, scuba_clean = scuba_clean)

return(x)
}

scuba_data <- load_data(logbook)

# Separate list into objects
scuba_map <- scuba_data$scuba_map
scuba_clean <- scuba_data$scuba_clean





#.........................................................
