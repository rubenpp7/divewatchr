#' Example of the certifications table
#'
#' A dataset containing an example of the certifications table, this table contains
#' an example of what the column names must be and how the content must look like.
#'
#' @format A data frame with 4 rows and 5 variables:
#' \describe{
#'   \item{diverID}{the diver identifier linked to the certification}
#'   \item{certificationName}{the name of the certification}
#'   \item{certificationAgency}{the name or acronym of the agency that issued the certification}
#'   \item{certificationDate}{the date when the certification was issued, in ISO8601}
#'   \item{instructorID}{the diver identifier of the instructor who taught the course and issued the certification}
#' }
"scuba_cert"