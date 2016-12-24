library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Geometric Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_geometric'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('geofunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('geoprops', class = 'shiny-text-output'))))
