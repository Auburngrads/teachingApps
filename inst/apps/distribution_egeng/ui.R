ui = navbarPage(title = 'Extended Generalized Gamma Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Shiny App',
         add_ui('distribution_egeng_functions')),

tabPanel('Distribution Functions',
         uiOutput('egengfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('egengprops', class = 'ta-text')))
