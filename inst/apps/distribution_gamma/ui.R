ui = navbarPage(title = 'Gamma Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Shiny App',
         add_ui('distribution_gamma_functions')),

tabPanel('Distribution Functions',
         uiOutput('gammafunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('gammaprops', class = 'ta-text')))
