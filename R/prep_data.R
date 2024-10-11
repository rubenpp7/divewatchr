#' Prepares the data
#'
#' Loads and prepares the logbook data from the data repository into the R session
#'
#' This function reads, prepares and locates in the chosen repository the data from the database
#' so it can be used by the rest of the functions
#' 
#' @param data The URL ID of the database in google sheets, if no URL is provided a mock dataset generated
#' by the test_data function will be read
#' @param path directory location where the files will be read from or written into
#' @param email email account that will be used to access the Logbook in Google Spreadsheet
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
#' prep_data()
#' \dontrun{
#' prep_data("1PpXTVS8LdzbvwLHyAAhR2MdT9Iwdy-hiqJknUzF7Yqo")
#' }




prep_data <- function (data = NA,
                       email = NA,
                       path = getwd()){

### READ DATA
#-------------

if(!is.na(data)){  
# From Google sheets
# gs4_auth(email, cache = ".secrets")
google_auth()
(scuba_log <- read_sheet(data, sheet = "logbook", na = "")) 
(scuba_geo <- read_sheet(data, sheet = "coordinates", na = ""))
(scuba_typ <- read_sheet(data, sheet = "divetypes", na = ""))
(scuba_cert <- read_sheet(data, sheet = "certifications", na = ""))  
} else {
example_data() # not necessary this line because data will be a permanent shared folder and downloadable -- see later
# From the test_data (in case sheets don't work)
(scuba_log <- read.csv(paste0(path, "/data-raw/logbook.csv") ))
(scuba_geo <- read.csv(paste0(path, "/data-raw/coordinates.csv") ))
(scuba_typ <- read.csv(paste0(path, "/data-raw/divetypes.csv") ))
(scuba_cert <- read.csv(paste0(path, "/data-raw/certifications.csv") ))  
}
#.........................................................
### DATA PROCESSING
#--------------------

## Making sure that there are no fields missing
  
  # Listing mandatory fields per table
log_fields <- c("eventDate", "locationID", "maximumDepthInMeters", "bottomTime", "waterTemperature",
            "diveType", "eventTime", "eventID")
geo_fields <- c("locationID", "locality", "region",	"country", "decimalLatitude", "decimalLongitude",	"platformType")
typ_fields <- c("diveType",	"diveClass")
cert_fields <- c("diverID", "certificationName", "certificationAgency", "certificationDate", "instructorID")


# Error message if missing mandatory fields
if(sum(!(log_fields %in% names(scuba_log))) |
   sum(!(geo_fields %in% names(scuba_geo))) |
   sum(!(typ_fields %in% names(scuba_typ))) |
   sum(!(cert_fields %in% names(scuba_cert)))) 
  
   stop('missing mandatory fields, create them even if they are empty. Mandatory fields: 
   
                       Logbook --> "eventDate", "locationID", "maximumDepthInMeters", "bottomTime", 
                                   "waterTemperature", "diveType", "eventTime", "eventID".
                                   
                       Coordinates --> "locationID", "locality", "region",	"country", "decimalLatitude",
                                       "decimalLongitude",	"platformType".
                                   
                       Divetypes --> "diveType",	"diveClass".
                                   
                       Certifications --> "diverID", "certificationName", "certificationAgency", 
                                         "certificationDate", "instructorID".')
  
  
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
                         waterTemperature = as.character(waterTemperature) %>%
                                            na_if("NULL"),
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


# scuba_cert to character
scuba_cert <- scuba_cert %>% mutate(certificationDate = as.character(certificationDate)) %>%
                             arrange(certificationDate)


if(!is.na(data)){ 
  if(!dir.exists(paste0(path, "/divewatchr_data"))) {dir.create("divewatchr_data")}
    save(scuba_map, file = paste0(path, "/divewatchr_data/scuba_map.RData"))
    save(scuba_clean, file = paste0(path, "/divewatchr_data/scuba_clean.RData"))
    save(scuba_cert, file = paste0(path, "/divewatchr_data/scuba_cert.RData"))
} else {
  if(!dir.exists(paste0(path, "/data"))) {dir.create("data")}
    save(scuba_map, file = paste0(path, "/data/scuba_map.RData"))
    save(scuba_clean, file = paste0(path, "/data/scuba_clean.RData"))
    save(scuba_cert, file = paste0(path, "/data/scuba_cert.RData"))
}

#save(scuba_map, file = paste0(path, "/data/scuba_map.rda"))
#save(scuba_clean, file = paste0(path, "/data/scuba_clean.rda"))
# save.image(paste0(path, "/data/scuba_map.RData"))
# save.image(paste0(path, "/data/scuba_clean.RData"))


# Return list with wanted objects
x <- list(scuba_map = scuba_map, scuba_clean = scuba_clean, scuba_cert = scuba_cert)

return(x)
}


#.........................................................

