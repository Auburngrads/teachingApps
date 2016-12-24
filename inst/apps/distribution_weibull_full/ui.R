library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Weibull Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_weibull'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('weibfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('weibprops', class = 'shiny-text-output'))))
