library(teachingApps)
library('DT')

ui = navbarPage(title = 'Table 3.5',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
    tabPanel(h4('Table 3.5'), DT::dataTableOutput('table5')))

