library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Exponential Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),

tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_exponential'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('expfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('expprops', class = 'shiny-text-output'))))
