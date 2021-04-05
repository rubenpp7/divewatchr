#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(shiny)
library(divewatchr)


path <<- "."
homed <<- getwd()


# Define UI for application that draws a histogram
ui <- fluidPage(
    
    
    conditionalPanel(condition="$('body').hasClass('disconnected')", tags$div("Disconnected\n refresh browser.",id="disconnectmess")),
    tags$script('Shiny.addCustomMessageHandler("setcookie",function(cookie) {document.cookie=cookie;});'),
    
    fluidRow(
        column(9,titlePanel("Divewatchr")),
        column(3,conditionalPanel(condition="$('html').hasClass('shiny-busy')",  HTML('<div class="fa-3x"><i class=\'fa fa-spinner fa-spin\' id=\'loadingIcon\'></i></div>')))
    ),
    # Application title
    #titlePanel("Old Faithful Geyser Data"),
    
    
    
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput('url','Google Spreadsheet page ID', value = "1PpXTVS8LdzbvwLHyAAhR2MdT9Iwdy-hiqJknUzF7Yqo"),
            actionButton("load","Load",icon("refresh")),
            uiOutput("downloadbutton") # to download the html file from divewatch()
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            htmlOutput("htmldives")
        )),
    
    
    
    
    
    
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    values<-reactiveValues(sourceURL="")  
    
    observe({
        query <- parseQueryString(session$clientData$url_search)
        if (!is.null(query[["baseurl"]]) & !is.null(query[["resource"]]))  {
            baseurl <-  query[["baseurl"]] 
            resource <-  query[["resource"]] 
            values$sourceURL <- paste0(baseurl, '/resource?r=', resource)
        }} )
    
    observeEvent(input$load,{
        if(!is.null(input$file))
            values$sourceURL<-input$file[4]
        else if(!is.null(input$url))
            values$sourceURL<-input$url
        
    }) 
    
    CheckDataset<-reactive({
        req(values$sourceURL)
        return(divewatch (values$sourceURL))
    })
    
    
    
    output$htmldives <-  renderUI ({
        IPTreport<-CheckDataset()
        
        includeHTML("overview.html") 
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
