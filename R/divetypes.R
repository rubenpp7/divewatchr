
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



#.........................................................

divetypes_platform <- function (data){

  # Plot platformTypes
  ggplot(scuba_clean, aes(x = platformType)) +
    geom_bar() +
    ggtitle("Platform type dives") +
    labs(x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

# Render the plot
divetypes_platform()
