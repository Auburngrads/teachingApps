library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Table 3.4',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
        
      tabPanel(h4('Data Set'),DT::dataTableOutput("table.shock1", height = "80%")),
      tabPanel(h4('Data Set'),DT::dataTableOutput("table.shock2", height = "80%")))
