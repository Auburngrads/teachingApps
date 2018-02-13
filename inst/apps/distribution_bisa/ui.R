ui = navbarPage(title = 'Bisa Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Shiny App',
         add_ui('distribution_bisa_functions')),

tabPanel('Distribution Functions',
         uiOutput('bisafunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('bisaprops', class = 'ta-text')))
