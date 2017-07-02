ui = navbarPage(title = 'The Delta Method',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel(h4('Background'),
         fluidRow(uiOutput('delta'), class = 'shiny-text-output')),

tabPanel(h4('Example'),
         fluidRow(uiOutput('greenwood'), class = 'shiny-text-output')))
