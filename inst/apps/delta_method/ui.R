ui = navbarPage(title = 'The Delta Method',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Background',
         uiOutput('delta', class = 'ta-text')),

tabPanel('Example',
         uiOutput('greenwood', class = 'ta-text')))
