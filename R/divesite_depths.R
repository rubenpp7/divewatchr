#' Depth variation per divesite
#'
#' Creates a plot with the variation of depths of the logged dives
#'
#' This function creates a boxplot to visualize the depth variation of the logged dives, offering an overview of the depth conditions
#' and opportunities of each divesite
#' 
#' @param toofew number of logged dives per divesite under which a divesite is excluded 
#' from the boxplot for having too few dives for an appropriate interpretation of the depth variation
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' @import dplyr
#' @import sf
#' 
#' @return Returns a boxplot.
#' 
#' @export


#.........................................................

divesite_depths <- function (toofew = 1){

  load("data/scuba_map.RData")

# Drop locations where there is only 1 dive since the point of this plot is showing variation
  y <- scuba_map %>% filter (locationID %in% (scuba_map %>%
                                                group_by(locationID) %>% 
                                                summarise(n = n()) %>%
                                                st_drop_geometry() %>%
                                                filter (n > toofew) %>%
                                                select (locationID))$locationID) %>%
                     arrange (rowid)
  
  
  # Plot location against depth  
  ggplot(y %>% filter(!is.na(maximumDepthInMeters)), 
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


