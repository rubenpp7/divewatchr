# library(tidyverse)
# library(leaflet) # for working with maps
# library(htmltools) # for working with html labels
# library(tmap)
# library(tmaptools)
# library(googlesheets4)
# library(lubridate) # for working with dates
# library(gridExtra) # for arranging plots
# library(ggthemes) # for ggplot themes
# library(sf) # for working with special feature 

library(dplyr) # pipe operator ***
library(ggplot2)  # for creating graphs ***
library(scales)   # to access breaks/formatting functions ***



cum_dives <- function(){

scuba_map_cum <- scuba_map %>% mutate(cum_dives = seq(1, nrow(scuba_map)))                     
     
ggplot(scuba_map_cum, 
       aes(x = as.Date(eventDate), y = as.numeric(cum_dives))) +
  geom_density2d(colour = "darkslategray", size = 1, alpha = 0.2) + 
  geom_step(alpha = 0.7) +
   geom_jitter(alpha = 0.4) +
   geom_smooth(colour = "chartreuse3", method = "loess", formula = 'y ~ x') +
 
  
  
 # cool geoms : geom_smooth!!! geom_density2d , geom_density_2d,  geom_count, geom_line, geom_jitter, geom_point, geom_step
  
  
  ggtitle("Cumulative dives") +
  labs(x = "Date",
       y = "Number of dives") +
  
  # Format dates in axis labels and date ticks
  scale_x_date(breaks=date_breaks("12 months"), 
               labels=date_format("%Y")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  
  
  geom_vline(xintercept = as.Date(c("2011-10-23", "2012-06-17", "2014-08-27", "2016-07-15")),
             linetype = "dashed",
             color = c("deepskyblue1","deepskyblue2","deepskyblue3","deepskyblue4"),
             size = 0.6,
             alpha = 0.6) 
}

cum_dives()



scuba_map_emo <- scuba_map %>% filter (eventID ==  "D4" | 
                                         eventID ==  "D14" |
                                         eventID ==  "D41" |
                                         eventID ==  "D73" ) %>%
  mutate (emoji = "emoji") %>%
  select (eventID, emoji) %>%
  st_drop_geometry() %>% 
  right_join(scuba_map, by = "eventID") %>%
  arrange(eventDate)


## Add text to the vlines https://stackoverflow.com/questions/18091721/align-geom-text-to-a-geom-vline-in-ggplot2
# cert=data.frame(date=as.Date(c("2011-10-23", "2012-06-17", "2014-08-27", "2016-07-15")), id=c("OWD", "AOWD", "Rescue Diver", "Divemaster"))
# 
# geom_vline(data=d, mapping=aes(xintercept=date), color="blue") +
# geom_text(mapping=aes(x=date, y=0, label=id), size=4, angle=90, vjust=-0.4, hjust=0) 




