ui = navbarPage(title = 'Beta Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
         add_ui('distribution_beta_functions')),

tabPanel('Distribution Functions',
         uiOutput('betafunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('betaprops', class = 'ta-text')))
