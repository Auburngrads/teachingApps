library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS(getShinyOption("css"))),
               
     mainPanel(width = 12, DT::dataTableOutput('amt')))

