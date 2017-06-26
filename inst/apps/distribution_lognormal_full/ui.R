library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Lognormal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_lognormal'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('lnorfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('lnorprops', class = 'shiny-text-output'))))
