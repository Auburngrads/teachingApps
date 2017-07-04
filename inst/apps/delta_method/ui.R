ui = navbarPage(title = 'The Delta Method',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Background',
      fluidRow(uiOutput('delta', class = 'ta-text'))),

tabPanel('Example',
      fluidRow(uiOutput('greenwood'), class = 'ta-text')))
