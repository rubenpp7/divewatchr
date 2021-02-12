#' Logbook highlights
#'
#' Creates a data frame with the highlights of the logbook
#'
#' This function creates a data frame to have an overview of some highlights of the diving logbook  
#' such as number of recorded dives, maximum bottom time or maximum depth
#' 
#' 
#' @author Ruben Perez Perez
#' 
#' @import tidyr
#' @import dplyr
#' @import stringr
#' 
#' @return Returns a data frame.
#' 
#' @export


#.........................................................

logbook_highlights <- function(){

load('data/scuba_clean.RData')

highlights <- gather(data.frame("Number_of_dives" = as.character(nrow(scuba_clean)),
                  "Number_of_dive_sites" = paste0(nrow(distinct(select(scuba_clean, locationID))),
                                                  " dive sites in ",
                                                  nrow(distinct(select(scuba_clean, country))),
                                                  " countries"), 
                  "Maximum_depth" = paste0(max(as.numeric(scuba_clean$maximumDepthInMeters), na.rm = TRUE), 
                                                    " meters"),
                  "Total_bottom_time" = paste0(round(sum(as.numeric(scuba_clean$bottomTime), na.rm = TRUE)/60), 
                                               " hours out of ",
                                               sum(!is.na(as.numeric(scuba_clean$bottomTime))),
                                               " recorded bottom times"),
                  "Maximum_bottom_time_in_a_dive" = paste0(max(as.numeric(scuba_clean$bottomTime), na.rm = TRUE), 
                                                                    " minutes"),
                  "Diving_since" = paste0(round(as.numeric(difftime(Sys.Date(), min(scuba_clean$eventDate), units = "days"))/365.25), 
                                          " years ago"),
                  "Last_dive" = paste0(max(scuba_clean$eventDate),
                                " = ",
                                paste0(round(as.numeric(difftime(Sys.Date(), max(scuba_clean$eventDate), units = "days"))), " days ago"))
                  ), 
       key = "Recorded", 
       value = "Value")

highlights$Recorded <- highlights$Recorded %>% str_replace_all("_", " ")

return(highlights)
  

}

########################################################################################################################################

# Using pipes
# data.frame("Number_of_dives" = scuba_clean %>% nrow() %>%
#                                                as.character(),
#            "Maximum_depth_recorded" = paste0(scuba_clean$maximumDepthInMeters %>% as.numeric() %>%
#                                                                                   max(na.rm = TRUE),
#                                              " meters"),
#            "Total_bottom_time" = paste0(scuba_clean$bottomTime %>% as.numeric() %>%
#                                                                    round(sum(na.rm = TRUE)/60) %>%
#                                                                    round(),
#                                         " hours"),
#            "Maximum_bottom_time_in_a_dive_recorded" = paste0(scuba_clean$bottomTime %>% as.numeric() %>%
#                                                                                         max(na.rm = TRUE),
#                                                              " minutes")),
#            "Diving_since" = paste0()
#                                              
#            
#                           
# ))
