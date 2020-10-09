# library(tidyverse)
# library(sf) # for working with special feature
# library(htmltools) # for working with html labels
# library(tmap)
# library(tmaptools)
# library(googlesheets4)
# library(lubridate) # for working with dates
# library(ggplot2)  # for creating graphs
# library(scales)   # to access breaks/formatting functions
# library(gridExtra) # for arranging plots
# library(ggthemes) # for ggplot themes
# library(dplyr)

library(leaflet) # for working with maps and the pipe operator ***



#.........................................................

logbook_map <- function (){

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

}

logbook_map()


# can also use
mapview::mapview(scuba_map)









