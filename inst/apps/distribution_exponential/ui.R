ui = navbarPage(title = 'Exponential Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Shiny App',
         add_ui('distribution_exponential_functions')),

tabPanel('Distribution Functions',
         uiOutput('expfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('expprops', class = 'ta-text')))
