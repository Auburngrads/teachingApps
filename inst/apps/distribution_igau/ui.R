ui = navbarPage(title = 'IGAU Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

tabPanel('Shiny App',
         add_ui('distribution_igau_functions')),

tabPanel('Distribution Functions',
         uiOutput('igaufunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('igauprops', class = 'ta-text')))
