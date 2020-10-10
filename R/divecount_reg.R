
library(ggplot2)  # for creating graphs ***


#.........................................................

divecount_reg <- function (data){
  
  # Plot dives per country and region
  
  ggplot(scuba_clean, aes(x = country, fill = paste0(region, ", " ,country))) +
    geom_bar(alpha = 0.7, position = "dodge2") +
    ggtitle("Dives per country and region") +
    labs(x = "",
         fill = "region") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}
# Render the plot
divecount_reg()
