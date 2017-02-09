library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Smallest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_sev'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('sevfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('sevprops', class = 'shiny-text-output'))))
