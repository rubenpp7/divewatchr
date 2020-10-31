#' Prepares the data
#'
#' Loads and prepares the logbook data from the data repository into the R session
#'
#' This function reads, prepares and locates in the chosen repository the data from the database
#' so it can be used by the rest of the functions
#' 
#' @param data The URL ID of the database in google spreadhsets.
#' 
#' @author Ruben Perez Perez
#' 
#' @import dplyr
#' @import sf
#' @import googlesheets4 
#' @import stringr
#' 
#' @return Reads one R list and the 2 dataframes within it into the R environment.
#' 
#' @export
#' @examples
#' prep_data("1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M")



# Logbook in google sheets
#logbook <- "1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M"




prep_data <- function (data = "1PpXTVS8LdzbvwLHyAAhR2MdT9Iwdy-hiqJknUzF7Yqo",
                       path = getwd()){

### READ DATA
#-------------

# From Google sheets
(scuba_log <- read_sheet(data, sheet = "logbook", na = "")) 
(scuba_geo <- read_sheet(data, sheet = "coordinates", na = ""))

#.........................................................
### DATA PROCESSING
#--------------------

## Preparation for Leaflet:


# Add coordinates and other geo data + Remove records with no coordinates to prepare dataset for map
scuba_clean <- scuba_log %>% mutate(rowid = str_remove(eventID, "D"),
                                    rowid = as.numeric(rowid)) %>%
                             left_join(scuba_geo, by = "locationID") %>%
                             filter (!is.na(decimalLatitude) & !is.na(decimalLatitude))

# Some columns need a special data type. eventDate needs to be character to be good as a label
scuba_clean <- scuba_clean %>%
                  mutate(decimalLatitude = as.numeric(decimalLatitude),
                         decimalLongitude = as.numeric(decimalLongitude),
                         eventDate = as.character(eventDate),
                         maximumDepthInMeters = as.character(maximumDepthInMeters),
                         bottomTime = as.character(bottomTime) ) %>%
                  select(-eventTime) %>% 
                  arrange(rowid)



# Extract coordinates
coords_scuba <-
  scuba_clean %>%
  select(rowid, decimalLongitude, decimalLatitude)

# Transform scuba_map to a sf data.frame (data in WGS84)
scuba_map <-
  st_as_sf(scuba_clean,
           coords = c("decimalLongitude", "decimalLatitude"),
           crs = 4326)
# Add coordinates as two extra columns
scuba_map <- scuba_map %>% left_join(coords_scuba, by = "rowid")  %>%
                           arrange(rowid)

# Double check the Coordinate Reference System (CRS)
print(st_crs(scuba_map))

if(!dir.exists(paste0(path, "/data"))) {dir.create("data")}
save(scuba_map, file = paste0(path, "/data/scuba_map.RData"))
save(scuba_clean, file = paste0(path, "/data/scuba_clean.RData"))
save(scuba_map, file = paste0(path, "/data/scuba_map.rda"))
save(scuba_clean, file = paste0(path, "/data/scuba_clean.rda"))
# save.image(paste0(path, "/data/scuba_map.RData"))
# save.image(paste0(path, "/data/scuba_clean.RData"))


# Return list with wanted objects
x <- list(scuba_map = scuba_map, scuba_clean = scuba_clean)

return(x)
}


#.........................................................
