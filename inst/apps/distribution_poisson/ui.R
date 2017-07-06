ui = navbarPage(title = 'Poisson Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_poisson_functions')),

tabPanel('Distribution Functions',
         uiOutput('poifunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('poiprops', class = 'ta-text')))
