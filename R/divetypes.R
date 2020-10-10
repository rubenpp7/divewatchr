# 
# library(tidyverse)
# library(sf) # for working with special feature
# library(leaflet) # for working with maps
# library(htmltools) # for working with html labels
# library(tmap)
# library(tmaptools)
# library(googlesheets4)
# library(lubridate) # for working with dates
# library(scales)   # to access breaks/formatting functions
# library(gridExtra) # for arranging plots
# library(ggthemes) # for ggplot themes
# library(dplyr)

library(ggplot2)  # for creating graphs ***



#.........................................................

divetypes_platform <- function (data){

  # Plot platformTypes
  ggplot(scuba_clean, aes(x = platformType, fill = paste0(region, ", " ,country))) +
    geom_bar(alpha = 0.7, position = "dodge2") +
    ggtitle("Platform type dives") +
    labs(x = "",
         fill = "region") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
}

# Render the plot
divetypes_platform()



