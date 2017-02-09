library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Largest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_lev'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('levfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('levprops', class = 'shiny-text-output'))))
