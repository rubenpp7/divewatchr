#' Creates a example dataset
#'
#' Creates a example dataset with the basic data to perform the visualizations of the package
#'
#' This function creates an example dataset with the structure 
#' needed to perform the visualization functions from the divewatchr package.
#' It can be used to run the other functions and to show the user how the data must look like.
#' The output dataset must be copypasted in a google sheets spreadsheet and the user
#' needs to make sure that the data is formatted as character/text
#' 
#' @param path directory location where the files will be read from or written into
#' 
#' @author Ruben Perez Perez
#' 
#' @import dplyr
#' 
#' @export
#' @return 4 csv files with example data.
#' @examples
#' example_data()


example_data <- function(path = getwd()){

example_data_logbook <- data.frame (eventDate = sample(seq(as.Date('1999/01/01'),
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
                                                    0.1, 0.02, 0.02 , 0.03)) ,
                         maximumDepthInMeters	= round(sample(seq(5, 37, by = 0.02), 500),1),
                         bottomTime	= round(sample(seq(25, 50, by = 0.02), 500),0),
                         waterTemperature	= NA,
                         visibility	= NA,
                         extraWeight	= NA,
                         diveType	= sample(c("Discover Scuba Diving Course"	,
                                             "Open Water Diver Course"	,
                                             "Fun Dive"	,
                                             "Research Dive"	,
                                             "Advanced Open Water Diver Course"	,
                                             "PADI Rescue Assistance"	,
                                             "PADI OWD Assistance"	,
                                             "PADI DSD Leading"	,
                                             "Rescue Diver Course"	,
                                             "Fun Dive Leading"	,
                                             "PADI AOWD Assistance"	,
                                             "PADI DSD Assistance"	,
                                             "Deep Course"	,
                                             "Deep Course / Nitrox Course"),
                                           500, replace=TRUE,
                                           prob=c(0.05, 0.08, 0.15, 0.05, 0.2,
                                                  0.08, 0.08, 0.02, 0.05, 0.07,
                                                  0.1, 0.02, 0.02 , 0.03)),
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



example_data_coordinates <- data.frame (locationID	= c("Piscina ZOEA"	,
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


example_data_divetypes <- data.frame (diveType = c("Advanced Open Water Diver Course"	,
                                                "Cleaning Dive Leading"	,
                                                "PADI AOWD Assistance"	,
                                                "PADI DSD Assistance"	,
                                                "PADI OWD Assistance"	,
                                                "PADI Rescue Assistance"	,
                                                "PADI DSD Leading"	,
                                                "PADI OWD Leading"	,
                                                "PADI Rescue Leading"	,
                                                "PADI ReActivate Leading"	,
                                                "Deep Course"	,
                                                "Deep Course / Nitrox Course"	,
                                                "Discover Scuba Diving Course"	,
                                                "Fun Dive"	,
                                                "Fun Dive Leading"	,
                                                "GUE Fundamentals Training"	,
                                                "Open Water Diver Course"	,
                                                "Other Dive"	,
                                                "Rescue Diver Course"	,
                                                "Research Dive"	,
                                                "Sidemount Course"	,
                                                "Training Dive"		
                                                  ),
                                     diveClass = c ("Training"	,
                                                    "Dive Leading"	,
                                                    "Course Assistance"	,
                                                    "Course Assistance"	,
                                                    "Course Assistance"	,
                                                    "Course Assistance"	,
                                                    "Course Leading"	,
                                                    "Course Leading"	,
                                                    "Course Leading"	,
                                                    "Course Leading"	,
                                                    "Training"	,
                                                    "Training"	,
                                                    "Training"	,
                                                    "Fun"	,
                                                    "Dive Leading"	,
                                                    "Training"	,
                                                    "Training"	,
                                                    "Other"	,
                                                    "Training"	,
                                                    "Research"	,
                                                    "Training"	,
                                                    "Training"))


example_data_certifications <- data.frame (diverID = c("XXXXXX",
                                                    "XXXXXX",
                                                    "XXXXXX",
                                                    "XXXXXX"
                                                    ),
                                        certificationName = c("Open Water Diver",
                                                              "Advanced Open Water Diver",
                                                              "Rescue Diver",
                                                              "Enriched Air Diver"
                                                              ),
                                        certificationAgency = c("PADI",
                                                                "PADI",
                                                                "PADI",
                                                                "PADI"
                                                                ),
                                        certificationDate = c("2011-10-23",
                                                              "2012-06-17",
                                                              "2014-08-24",
                                                              "2014-08-27"
                                                              ),
                                        instructorID = c("YYYYYY",
                                                    "YYYYYY",
                                                    "YYYYYY",
                                                    "YYYYYY"))



if(!dir.exists(paste0(path, "/data-raw"))) {dir.create("data-raw")}
write.csv(example_data_logbook, paste0(path, "/data-raw/logbook.csv"), row.names = FALSE, na = "")
write.csv(example_data_coordinates, paste0(path, "/data-raw/coordinates.csv"), row.names = FALSE, na = "")
write.csv(example_data_divetypes, paste0(path, "/data-raw/divetypes.csv"), row.names = FALSE, na = "")
write.csv(example_data_certifications, paste0(path, "/data-raw/certifications.csv"), row.names = FALSE, na = "")
          }
