#' Example of the logbook table in sf format
#'
#' A dataset containing an example of the logbook table in sf format, this table contains
#' an example of what the column names must be and how the content must look like.
#'
#' @format A "simple feature" and data frame with 500 rows and 31 variables:
#' \describe{
#'   \item{eventDate}{the date of the dive, in ISO8601}
#'   \item{locationID}{the name of the dive site}
#'   \item{maximumDepthInMeters}{the maximum depth of the dive, in meters}
#'   \item{bottomTime}{the bottom time of the dive, in minutes}
#'   \item{waterTemperature}{the average water temperature of the dive, in degrees celsius}
#'   \item{visibility}{the visibility during the dive, categorical not standardized yet}
#'   \item{extraWeight}{weight of the weight belt, in kilograms}
#'   \item{diveType}{main type of dive, categorical}
#'   \item{diveType_2}{secondary type of dive, not necessary}
#'   \item{diveType_3}{terciary type of dive, not necessary}
#'   \item{stop}{safety or emergency or no stop, not necessary}
#'   \item{deepDive}{not necessary}
#'   \item{nightDive}{not necessary}
#'   \item{sidemountDive}{not necessary}
#'   \item{boatDive}{not necessary}
#'   \item{shoreDive}{not necessary}
#'   \item{driftDive}{not necessary}
#'   \item{caveDive}{not necessary}
#'   \item{wreckDive}{not necessary}
#'   \item{eventID}{identifier of each dive}
#'   \item{rowid}{number of row}
#'   \item{locality}{place where the dive site is located, village or town}
#'   \item{region}{region where the dive site is located}
#'   \item{country}{region where the dive site is located}
#'   \item{decimalLatitude}{latitude of the dive site, in decimal degrees}   
#'   \item{decimalLongitude}{longitude of the dive site, in decimal degrees}   
#'   \item{platformType}{the type of dive regarding the entry platform, shore, boat or pool}   
#'   \item{wreckType}{not necessary}
#'   \item{caveType}{not necessary}
#'   \item{diveClass}{main class of the dive, it groups several diveTypes into one diveClass, categorical}
#'   \item{geometry}{coordinates of the dive site in Points format}
#' }
"scuba_map"