library(teachingApps)
library('SMRD')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS("www/custom.css")),
             
sidebarLayout(
  sidebarPanel(width = 3,
    selectInput("n7.3", 
                label = h2("Observations:"),
                choices = c("20", "200", "2000", "10220"), 
                selected = "20")),
     
     mainPanel(plotOutput('berksonmle', height = '600px'), width = 9)))
