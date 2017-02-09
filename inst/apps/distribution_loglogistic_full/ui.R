library(teachingApps)
library(metricsgraphics)
library(actuar)

ui = navbarPage(title = 'Loglogistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_loglogistic'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('llogfunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('llogprops', class = 'shiny-text-output'), width = 12)))
