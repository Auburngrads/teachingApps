library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Table 3.4',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
        
      tabPanel(h4('Data Set'),DT::dataTableOutput("table.shock1", height = "80%")),
      tabPanel(h4('Data Set'),DT::dataTableOutput("table.shock2", height = "80%")))
