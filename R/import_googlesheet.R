#Work on progress, it doesnt work yet







library(googlesheets)
library(dplyr) 
library(gsheet)


#----------------------------------------------
# METHOD 1

# Guidelines in :
# https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html#authorization-using-oauth2
# https://github.com/jennybc/googlesheets

(my_sheets <- gs_ls())
my_sheets %>% glimpse()

gs_auth(new_user = T) 
gs_user()


#-----------------------------------------------
# METHOD 2
# Guidelines in : 
# https://github.com/maxconway/gsheet

scuba <-gsheet2tbl('docs.google.com/spreadsheets/d/1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M')
b <- gsheet2text(scuba, format='csv')
b <- read.csv(a, stringsAsFactors=FALSE)

gsheet2tbl('docs.google.com/spreadsheets/d/1I9mJsS5QnXF2TNNntTy-HrcdHmIF9wJ8ONYvEJTXSNo')
# Why doesnt work?
gsheet2tbl('docs.google.com/spreadsheets/d/1qO7_0K1R-4i_MSgtT3zAYbZfxBmPMgQWAi7OmWmb1-M')
