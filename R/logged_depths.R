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



# The problem of making the previous function is that scuba_map does not get generated

# Plot date against max depths https://www.neonscience.org/dc-time-series-plot-ggplot-r
logged_depths <- ggplot(scuba_map %>% filter (!is.na(maximumDepthInMeters)), 
                      aes(x = as.Date(eventDate), y = -as.numeric(maximumDepthInMeters),
                          fill = -as.numeric(maximumDepthInMeters))) +
  geom_jitter (size = 5, alpha = 0.7, shape = 21, width = 5) + # Incrase width for more explicit visualization, although it compromises it the veracity of the data
  # theme_classic() +
  # scale_color_economist () +
  #  geom_rangeframe() +
  # theme_tufte() +
  ggtitle("Dives depth") +
  labs(fill = "Max Depth (metres)",
       x = "Date",
       y = "") + # I hide the y axis label because it is already specified in the color legend
  
  # Format dates in axis labels and date ticks
  scale_x_date(breaks=date_breaks("12 months"), 
               labels=date_format("%Y")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  
  
  geom_hline(yintercept = c(0, -20, -40), linetype = c("dotdash", "dashed", "solid"), 
             color = c("darkgrey", "deepskyblue4", "red"), size = 0.5, alpha = 0.6) 

# Render the plot
logged_depths 