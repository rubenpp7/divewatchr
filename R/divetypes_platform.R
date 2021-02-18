#' Number of dives per dive platform type
#'
#' Creates a barplot with the number of dives per region and country and platform type
#'
#' This function creates a barplot to visualize the number of dives per region and platform type "poolDive", "boatDive" or "shoreDive"
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' 
#' @return Returns a barplot.
#' 
#' @export


#.........................................................

divetypes_platform <- function (path = getwd()){
  
  if(dir.exists(paste0(path, "/divewatchr_data"))){
    
    load('divewatchr_data/scuba_clean.RData')
  }
  # Plot platformTypes
  ggplot(scuba_clean, aes(x = platformType, fill = paste0(region, ", " ,country))) +
    geom_bar(alpha = 0.7, position = "dodge2") +
    ggtitle("Platform type dives") +
    labs(x = "",
         fill = "Region") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
}




