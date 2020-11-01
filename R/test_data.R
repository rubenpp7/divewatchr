#' Creates a fake dataset
#'
#' Creates a fake dataset with the basic data to perform the visualizations of the package
#'
#' This function creates a model dataset with the structure 
#' needed to perform the visualization functions from the divewatchr package.
#' It can be used to test the other functions and to show the user how the data must look like.
#' The output dataset must be copypasted in a google sheets spreadsheet and the user
#' needs to make sure that the data is formatted as character/text
#' 
#' @author Ruben Perez Perez
#' 
#' @import dplyr
#' 
#' @export
#' @return 2 csv files with fake data.
#' 


test_data <- function(path = getwd()){

test_data_logbook <- data.frame (eventDate = sample(seq(as.Date('1999/01/01'),
                                                  as.Date('2020/01/01'),
                                                  by="day"), 500),
                         eventTime = NA,
                         locationID	= sample(c("Piscina ZOEA"	,
                                               "Marina del Este"	,
                                               "La Cueva de la Virgen"	,
                                               "Chocolate Island"	,
                                               "Pared Sur del Fraile"	,
                                               "Kalanggaman Island"	,
                                               "Um El-Faroud"	,
                                               "A catedral"	,
                                               "Praia do Martinhal"	,
                                               "Exiles"	,
                                               "Tug 2"	,
                                               "HMS Maori"	,
                                               "Dreischor gemaal"	,
                                               "Oesterdam"),
                                             500, replace=TRUE,
                                             prob=c(0.05, 0.08, 0.15, 0.05, 0.2,
                                                    0.08, 0.08, 0.02, 0.05, 0.07,
                                                    0.1, 0.02, 0.02 , 0.03)),
                         maximumDepthInMeters	= round(sample(seq(5, 37, by = 0.02), 500),1),
                         bottomTime	= round(sample(seq(25, 50, by = 0.02), 500),0),
                         waterTemperature	= NA,
                         visibility	= NA,
                         extraWeight	= NA,
                         diveType_1	= NA,
                         diveType_2	= NA,
                         diveType_3	= NA,
                         stop	= NA,
                         deepDive	= NA,
                         nightDive	= NA,
                         sidemountDive	= NA,
                         boatDive	= NA,
                         shoreDive	= NA,
                         driftDive	= NA,
                         caveDive	= NA,
                         wreckDive = NA) %>%
             arrange(eventDate) %>%
             mutate (eventID = paste0("D", 1:500))



test_data_coordinates <- data.frame (locationID	= c("Piscina ZOEA"	,
                                                    "Marina del Este"	,
                                                    "La Cueva de la Virgen"	,
                                                    "Chocolate Island"	,
                                                    "Pared Sur del Fraile"	,
                                                    "Kalanggaman Island"	,
                                                    "Um El-Faroud"	,
                                                    "A catedral"	,
                                                    "Praia do Martinhal"	,
                                                    "Exiles"	,
                                                    "Tug 2"	,
                                                    "HMS Maori"	,
                                                    "Dreischor gemaal"	,
                                                    "Oesterdam"
),
                                     locality	= c("Aguilas"	,
                                                  "Almunecar"	,
                                                  "Cabo de Cope"	,
                                                  "Chocolate Island"	,
                                                  "Aguilas"	,
                                                  "Kalanggaman Island"	,
                                                  "Zurrieq Valley"	,
                                                  "Sagres"	,
                                                  "Sagres"	,
                                                  "Exiles"	,
                                                  "Exiles"	,
                                                  "St Elmo Bay"	,
                                                  "Grevelingenmeer"	,
                                                  "Tholen"
                                     ),
                                     region	= c("Murcia"	,
                                                "Granada"	,
                                                "Murcia"	,
                                                "Central Visayas"	,
                                                "Murcia"	,
                                                "Central Visayas"	,
                                                "Qrendi"	,
                                                "Algarve"	,
                                                "Algarve"	,
                                                "Sliema"	,
                                                "Sliema"	,
                                                "Valletta"	,
                                                "Zeeland"	,
                                                "Zeeland"
                                     ),
                                     country	= c("Spain"	,
                                                 "Spain"	,
                                                 "Spain"	,
                                                 "Philippines"	,
                                                 "Spain"	,
                                                 "Philippines"	,
                                                 "Malta"	,
                                                 "Portugal"	,
                                                 "Portugal"	,
                                                 "Malta"	,
                                                 "Malta"	,
                                                 "Malta"	,
                                                 "Netherlands"	,
                                                 "Netherlands"
                                     ),
                                     decimalLatitude	= c(37.39575	,
                                                         36.722489	,
                                                         37.424511	,
                                                         11.305414	,
                                                         37.407431	,
                                                         11.11695	,
                                                         35.819086	,
                                                         37.006141	,
                                                         37.018291	,
                                                         35.918614	,
                                                         35.919331	,
                                                         35.902885	,
                                                         51.747398	,
                                                         51.516707
                                     ),
                                     decimalLongitude	= c(-1.599959	,
                                                          -3.728296	,
                                                          -1.500004	,
                                                          124.064415	,
                                                          -1.547101	,
                                                          124.245713	,
                                                          14.449771	,
                                                          -8.92733	,
                                                          -8.925847	,
                                                          14.498422	,
                                                          14.498331	,
                                                          14.51588	,
                                                          3.89119	,
                                                          4.17167
                                     ),
                                     platformType	= sample(c("shoreDive", "boatDive", "poolDive"),
                                                           14, replace=TRUE,
                                                           prob=c(0.6, 0.3, 0.1)),
                                     wreckType	= NA,
                                     caveType = NA)

if(!dir.exists(paste0(path, "/test_data"))) {dir.create("test_data")}
write.csv(test_data_logbook, paste0(path, "/test_data/logbook.csv"), row.names = FALSE, na = "")
write.csv(test_data_coordinates, paste0(path, "/test_data/coordinates.csv"), row.names = FALSE, na = "")

          }
