ui = navbarPage(title = 'Largest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
        add_ui('distribution_lev_functions')),

tabPanel('Distribution Functions',
         uiOutput('levfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('levprops', class = 'ta-text')))
