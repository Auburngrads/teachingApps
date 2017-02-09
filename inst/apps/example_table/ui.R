library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS("www/custom.css")),
               
     mainPanel(width = 12, DT::dataTableOutput('amt')))

