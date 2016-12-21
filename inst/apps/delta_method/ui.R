library(teachingApps)
library(SMRD)

ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'The Delta Method',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4('Background'),
         fluidRow(uiOutput('delta'), class = 'shiny-text-output')),

tabPanel(h4('Example'),
         fluidRow(uiOutput('greenwood'), class = 'shiny-text-output')))
