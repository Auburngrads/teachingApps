library(teachingApps)
library('DT')

ui = navbarPage(title = 'Pseudorandom Observations',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                  
    tabPanel(h4('PRN Data'), DT::dataTableOutput('prn')))

