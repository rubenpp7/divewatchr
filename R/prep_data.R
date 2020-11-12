#' Prepares the data
#'
#' Loads and prepares the logbook data from the data repository into the R session
#'
#' This function reads, prepares and locates in the chosen repository the data from the database
#' so it can be used by the rest of the functions
#' 
#' @param data The URL ID of the database in google sheets, if no URL is provided a mock dataset generated
#' by the test_data function witll be read
#' @param path directory location where the files will be read from or written into
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
#' prep_data("1PpXTVS8LdzbvwLHyAAhR2MdT9Iwdy-hiqJknUzF7Yqo")




prep_data <- function (data = NA,
                       path = getwd()){

### READ DATA
#-------------

if(!is.na(data)){  
# From Google sheets
(scuba_log <- read_sheet(data, sheet = "logbook", na = "")) 
(scuba_geo <- read_sheet(data, sheet = "coordinates", na = ""))
(scuba_typ <- read_sheet(data, sheet = "divetypes", na = ""))
}
else{
test_data()
# From the test_data (in case sheets don't work)
(scuba_log <- read.csv(paste0(path, "/test_data/logbook.csv") ))
(scuba_geo <- read.csv(paste0(path, "/test_data/coordinates.csv") ))
(scuba_typ <- read.csv(paste0(path, "/test_data/divetypes.csv") ))
}
#.........................................................
### DATA PROCESSING
#--------------------

## Preparation for Leaflet:


# Add coordinates and other geo data + Remove records with no coordinates to prepare dataset for map
scuba_clean <- scuba_log %>% mutate(rowid = str_remove(eventID, "D"),
                                    rowid = as.numeric(rowid)) %>%
                             left_join(scuba_geo, by = "locationID") %>%
                             left_join(scuba_typ, by = "diveType") %>%
                             filter (!is.na(decimalLatitude) & !is.na(decimalLatitude))

# Some columns need a special data type. eventDate needs to be character to be good as a label
scuba_clean <- scuba_clean %>%
                  mutate(decimalLatitude = as.numeric(decimalLatitude),
                         decimalLongitude = as.numeric(decimalLongitude),
                         eventDate = as.character(eventDate),
                         maximumDepthInMeters = as.character(maximumDepthInMeters),
                         bottomTime = as.character(bottomTime),
                         diveType = as.character(diveType)) %>%
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

