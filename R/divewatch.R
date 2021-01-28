#' Creates an overview of the logbook
#'
#' Creates an .html file with an overview of the diving logbook loaded
#'
#' This function uses all the other functions of the divewatchr R package to create a visual overview
#' of the diving logbook loaded using plots and maps in order to to explore it 
#' 
#' @param data The URL ID of the database in google sheets, if no URL is provided a mock dataset generated
#' by the test_data function will be read
#' 
#' @author Ruben Perez Perez
#' 
#' @import rmarkdown
#' 
#' @return Creates an overview.html file with an overview of the diving logbook and creates a Fig folder with the images from the overview
#' 
#' @export
#' @examples
#' divewatch("1PpXTVS8LdzbvwLHyAAhR2MdT9Iwdy-hiqJknUzF7Yqo")


divewatch <- function(data = NA){
              prep_data(data)
              render("files/overview.Rmd")
}

