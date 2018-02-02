ui = navbarPage(title = 'Hypergeometric Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Shiny App',
         add_ui('distribution_hypergeometric_functions')),

tabPanel('Distribution Functions',
         uiOutput('hyperfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('hyperprops', class = 'ta-text')))
