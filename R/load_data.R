#' Loads logbook data into the R session
#'
#' This function reads and updates data files from the database.
#' @param data The URL ID of the database in google spreadhsets.
#' @return Reads one R list and the 2 dataframes within it into the R environment.
#' @export
#' @examples
#' load_data("1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M")


## library(tidyverse)
## library(leaflet) # for working with maps
## library(htmltools) # for working with html labels
## library(tmap)
## library(tmaptools)
## library(lubridate) # for working with dates
## library(ggplot2)  # for creating graphs
## library(scales)   # to access breaks/formatting functions
## library(gridExtra) # for arranging plots
## library(ggthemes) # for ggplot themes

library(dplyr) # ***
library(sf) # for working with special feature ***
library(googlesheets4) # GOOD ***





# Logbook in google sheets
logbook <- "1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M"




load_data <- function (data){

### READ DATA
#-------------

# From Google sheets
(scuba_log <- read_sheet(data, sheet = 1, na = ""))
(scuba_geo <- read_sheet(data, sheet = 3, na = ""))

#.........................................................



### DATA PROCESSING
#--------------------

## Preparation for Leaflet:

# Add coordinates and other geo data + Remove records with no coordinates to prepare dataset for map
scuba_clean <- scuba_log %>% left_join(scuba_geo, by = "locationID") %>%
                             filter (!is.na(decimalLatitude) & !is.na(decimalLatitude))

# Some columns need a special data type. eventDate needs to be character to be good as a label
scuba_clean <<- scuba_clean %>%
                  mutate(decimalLatitude = as.numeric(decimalLatitude),
                         decimalLongitude = as.numeric(decimalLongitude),
                         eventDate = as.character(eventDate),
                         maximumDepthInMeters = as.character(maximumDepthInMeters),
                         bottomTime = as.character(bottomTime) ) %>%
                  select(-eventTime) %>% 
                  arrange(eventDate)

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
  scuba_map <<- scuba_map %>% bind_cols(coords_scuba) %>% 
                              arrange(eventDate)

# Double check the Coordinate Reference System (CRS)
print(st_crs(scuba_map))

# Return list with wanted objects
x <- list(scuba_map = scuba_map, scuba_clean = scuba_clean)

return(x)
}

scuba_data <- load_data(logbook)

# Create data tables as objects so I don't have to run the function everytime (needs R package)
# usethis::use_data(scuba_map, overwrite = TRUE)
# usethis::use_data(scuba_clean, overwrite = TRUE)


#.........................................................
