ui = navbarPage(title = 'Binomial Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Shiny App',
         add_ui('distribution_binomial_functions')),

tabPanel('Distribution Functions',
         uiOutput('binomfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('binomprops', class = 'ta-text')))
