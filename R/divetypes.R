#' Number of dives per dive type
#'
#' Creates a barplot with the number of dives types
#'
#' This function creates a barplot to visualize the number of dives types "Course Leading", "Course Assistance", etc.
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' 
#' @return Returns a barplot.
#' 
#' @export


#.........................................................

divetypes <- function (){
  
  load("data/scuba_clean.RData")
  # Plot platformTypes
 count(scuba_clean, diveType) %>% 
   ggplot(aes(x = reorder(diveType, -n), y = n)) +
    geom_col(alpha = 0.7, position = "dodge2") +
    ggtitle("Dive types") +
    labs(x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
}

