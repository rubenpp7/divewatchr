#' Number of dives per region plot
#'
#' Creates a plot with the number of dives per region and country
#'
#' This function creates a barplot to visualize the number of dives per region
#' 
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' 
#' @return Returns a barplot.
#' 
#' @export


#.........................................................

divecount_reg <- function (){
  
  # Plot dives per country and region
  load("data/scuba_clean.RData")
  
  ggplot(scuba_clean, aes(x = country, fill = paste0(region, ", " ,country))) +
    geom_bar(alpha = 0.7, position = "dodge2") +
    ggtitle("Dives per country and region") +
    labs(x = "",
         fill = "Region") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

