#' Logged dive max depths
#'
#' Creates a scatterplot with the logged maximum depths through time
#'
#' This function creates a scatterplot to visualize the maximum depths logged through time, offering a nice overview
#' of the diving experience regarding depth
#' 
#' @param path directory location where the files will be read from or written into
#' 
#' @author Ruben Perez Perez
#' 
#' @import ggplot2
#' @import dplyr
#' @import scales
#' @import sf
#' @importFrom ggExtra ggMarginal
#' 
#' @return Returns a boxplot.
#' 
#' @export

#-----------------------------------------------------------------------------------------------------


logged_depths <- function (path = getwd()){
  
  if(dir.exists(paste0(path, "/divewatchr_data"))){
    
    load('divewatchr_data/scuba_map.RData')
  }
# The problem of making the previous function is that scuba_map does not get generated

# Plot date against max depths https://www.neonscience.org/dc-time-series-plot-ggplot-r
  p <- ggplot(scuba_map %>% filter (!is.na(maximumDepthInMeters)), 
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

 ggMarginal(p, type="densigram", fill = "dodgerblue3", size = 9, alpha = 0.5)  
 
}

