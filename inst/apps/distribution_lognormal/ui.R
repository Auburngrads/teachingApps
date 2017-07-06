ui = navbarPage(title = 'Lognormal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_lognormal_functions')),

tabPanel('Distribution Functions',
         uiOutput('lnorfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('lnorprops', class = 'ta-text')))
