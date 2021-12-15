#' Number of dives per region plot
#'
#' Creates a plot with the number of dives per region and country
#'
#' This function creates a barplot to visualize the number of dives per region
#' 
#' @param path directory location where the files will be read from or written into
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' 
#' @return Returns a barplot.
#' 
#' @export


#.........................................................

divecount_reg <- function (path = getwd()){
  
  if(dir.exists(paste0(path, "/divewatchr_data"))){
    
    load('divewatchr_data/scuba_clean.RData')
  }
  
  ggplot(scuba_clean %>% filter(platformType != "poolDive"), aes(x = country, fill = paste0(region, ", " ,country))) +
    geom_bar(alpha = 0.7, position = "dodge2") +
    ggtitle("Dives per country, region and platform") +
    labs(x = "",
         fill = "Region") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    facet_grid(factor(platformType, levels=c('boatDive','shoreDive')) ~., scales="free") 
}

