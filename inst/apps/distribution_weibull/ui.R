ui = navbarPage(title = 'Weibull Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_weibull_functions')),

tabPanel('Distribution Functions',
         uiOutput('weibfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('weibprops', class = 'ta-text')))
