ui = navbarPage(title = 'Logistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_logistic_functions')),

tabPanel('Distribution Functions',
         uiOutput('logfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('logprops', class = 'ta-text')))
