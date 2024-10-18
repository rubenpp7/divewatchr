#' Uses the edit rights to a Google sheets if they are stored by the user
#'
#' Stores the authentication token in a file and uses it to access the Google sheet
#'
#' This function allows Github Action and a users that has a token stored to access a Google sheet to
#' retrieve the data from a given google sheet
#' 
#' @param email email account that will be used to access the Logbook in Google Spreadsheet
#' 
#' @author Ruben Perez Perez
#' 
#' @import googlesheets4
#' 
#' @return It provides access to a given Google sheet if there is a token stored.
#' 
#' @export
#' @examples
#' divewatch()
#' \dontrun{
#' google_auth()
#' }

google_auth <- function(email = NA) {


# Path to save the decoded OAuth token
oauth_token_path <- ".config/gcloud/google-oauth-token.rds"

# Check if we are running in GitHub Actions by looking for the environment variable
# if (Sys.getenv("GITHUB_ACTIONS") == "true") {
#   # Retrieve the Base64-encoded OAuth token from the environment (GitHub Secrets)
#   base64_token <- Sys.getenv("GOOGLE_OAUTH_TOKEN_BASE64")
#   
#   # Decode the Base64 string and write it to a binary RDS file
#   decoded_token <- base64decode(base64_token)
#   writeBin(decoded_token, oauth_token_path)
# }

# Load the OAuth token from the RDS file and authenticate
if (file.exists(oauth_token_path)) {
  token <- readRDS(oauth_token_path)
  gs4_auth(token = token)
} else {
  print("OAuth token not found in directory.")
  gs4_auth(email, cache = ".secrets")
}

return()
}
