# library(tidyverse)
# library(sf) # for working with special feature
# library(leaflet) # for working with maps
# library(htmltools) # for working with html labels
# library(tmap)
# library(tmaptools)
# library(googlesheets4)
# library(lubridate) # for working with dates
# library(gridExtra) # for arranging plots
# library(ggthemes) # for ggplot themes
library(dplyr) # for the pipe operator ***
library(ggplot2)  # for creating graphs ***
library(scales)   # to access breaks/formatting functions ***

#-----------------------------------------------------------------------------------------------------


logged_depths <- function (){

# The problem of making the previous function is that scuba_map does not get generated

# Plot date against max depths https://www.neonscience.org/dc-time-series-plot-ggplot-r
 ggplot(scuba_map %>% filter (!is.na(maximumDepthInMeters)), 
                      aes(x = as.Date(eventDate), y = -as.numeric(maximumDepthInMeters),
                          fill = -as.numeric(maximumDepthInMeters))) +
  geom_jitter (size = 5, alpha = 0.7, shape = 21, width = 5) + # Increase width for more explicit visualization, although it compromises it the veracity of the data
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

}

# Render the plot
logged_depths()
