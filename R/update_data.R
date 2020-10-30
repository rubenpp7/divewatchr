#' Updating data
#'
#' Updates and stores the .rda and .RData data files in the chosen location
#'
#' This function reads, updates and prepares the data from the data repository, 
#' it also locates it in the chosen repository so it can be pulled by the rest of the functions as 
#' a data example
#' 
#' @param data The URL ID of the database in google spreadhsets.
#' @param path The location where the formatted database will be stored
#' 
#' @author Ruben Perez Perez
#' 
#' @import divewatchr
#' @import usethis
#' 
#' @return Reads one R list and the 2 dataframes within it into the R environment.
#' 
#' @export
#' @examples
#' load_data()


update_data <- function (data = "1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M", 
                         path = "C:/Users/rubenp/Desktop/Huiswerk 2020/Logbook Scuba Ruben Perez/divewatchr/data/") {

  prep_data(data)

# Create data tables as objects so I don't have to run the function everytime (needs R package)
use_data(scuba_map, overwrite = TRUE)
use_data(scuba_clean, overwrite = TRUE)

# For some reason the previous .rda data files can't be read by the map/leaflet function so we save them also as .RData data files
save.image(paste0(path, "scuba_map.RData"))
save.image(paste0(path, "scuba_clean.RData"))

}

update_data()
