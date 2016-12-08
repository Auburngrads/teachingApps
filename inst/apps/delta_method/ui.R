library(teachingApps)
library(SMRD)

ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'The Delta Method',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),
                
tabPanel(h4('Background'),
         fluidRow(uiOutput('delta'), class = 'shiny-text-output')),

tabPanel(h4('Example'),
         fluidRow(uiOutput('greenwood'), class = 'shiny-text-output')))
