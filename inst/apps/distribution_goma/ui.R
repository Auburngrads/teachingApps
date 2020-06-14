ui = navbarPage(title = 'GOMA Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

tabPanel('Shiny App',
         add_ui('distribution_goma_functions')),

tabPanel('Distribution Functions',
         uiOutput('gomafunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('gomaprops', class = 'ta-text')))
