#' Number of dives per dive type
#'
#' Creates a barplot with the number of dives types
#'
#' This function creates a barplot to visualize the number of dives types "Course Leading", "Course Assistance", etc.
#' 
#' @param n.other number of dives under which a diveType is placed into the "Other" category.
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' @import dplyr
#' @import forcats
#' 
#' @return Returns a barplot.
#' 
#' @export


#.........................................................

divetypes <- function (n.other = 4, path = getwd()){
  
  if(dir.exists(paste0(path, "/divewatchr_data"))){
    
    load('divewatchr_data/scuba_clean.RData')
  }
  # Plot platformTypes
types <-  count(scuba_clean, diveType, diveClass) %>%
          mutate(diveType = ifelse(n < n.other, "Other", diveType),
                 diveClass = ifelse(n < n.other, "Other", diveClass),
                 diveType = ifelse(diveType == "Unknown", "Other", diveType),
                 diveType = fct_reorder(diveType, -n)) 

types_sum <- aggregate(n ~ diveType, data=types, sum) %>%
             left_join(select(types, -n), by = "diveType") %>%
             distinct()

    ggplot(data = types_sum, aes(x = diveType, y = n, fill = diveClass)) +
    geom_col(alpha = 0.7) +
    ggtitle("Dive types") +
    labs(x = "",
         y = "Number of dives",
         fill = "Dive Class") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_text(data = types_sum, aes(x = diveType, y = n + max(n)/15, label = n),
              size = 3)
  
}
