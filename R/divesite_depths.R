
# library(tidyverse)
# library(leaflet) # for working with maps
# library(htmltools) # for working with html labels
# library(tmap)
# library(tmaptools)
# library(googlesheets4)
# library(lubridate) # for working with dates
# library(scales)   # to access breaks/formatting functions
# library(gridExtra) # for arranging plots
# library(ggthemes) # for ggplot themes

library(dplyr) # pipe operator ***
library(ggplot2)  # for creating graphs ***
library(sf) # for working with special feature ***



#.........................................................

divesite_depths <- function (data){

# Plot location against depth

  ggplot(scuba_map %>% filter (!is.na(maximumDepthInMeters)), 
         aes(x = reorder(as.factor(locationID), as.numeric(maximumDepthInMeters), FUN = median), # replace locationID by locality to see it by locality
             y = -as.numeric(maximumDepthInMeters), 
             fill = paste0(locality, ", ", country))) +
  # reorder(Species, Sepal.Width, FUN = median)
  ggtitle("Divesite depths") +
  labs(x = "locationID",
       y = "Depth",
       fill = "Locality") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_boxplot () # +
    # facet_wrap(~country) # Interesting but not yet very useful, need to polish it

# intentar agrupar las boxes por locality , check https://stackoverflow.com/questions/43877663/order-multiple-variables-in-ggplot2
}

# Render the plot
divesite_depths()

