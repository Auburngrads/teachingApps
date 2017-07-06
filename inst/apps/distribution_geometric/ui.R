ui = navbarPage(title = 'Geometric Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_geometric_functions')),

tabPanel('Distribution Functions',
         uiOutput('geofunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('geoprops', class = 'ta-text')))
