ui = navbarPage(title = 'Loglogistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_loglogistic_functions')),

tabPanel('Distribution Functions',
         uiOutput('llogfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('llogprops', class = 'ta-text')))
