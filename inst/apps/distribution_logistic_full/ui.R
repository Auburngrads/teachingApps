library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Logistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_logistic'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('logfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('logprops', class = 'shiny-text-output'))))
