
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



# Plot location against depth
divesite_depths <- 
  
  
  ggplot(scuba_map %>% filter (!is.na(maximumDepthInMeters)), 
         aes(x = reorder(as.factor(locationID), as.numeric(maximumDepthInMeters), FUN = median), # replace locationID by locality to see it by locality
             y = -as.numeric(maximumDepthInMeters), 
             fill = locality)) +
  # reorder(Species, Sepal.Width, FUN = median)
  ggtitle("Divesite depths") +
  labs(x = "locationID",
       y = "Depth") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_boxplot ()

# intentar agrupar las boxes por locality , check https://stackoverflow.com/questions/43877663/order-multiple-variables-in-ggplot2


# Render the plot
divesite_depths
