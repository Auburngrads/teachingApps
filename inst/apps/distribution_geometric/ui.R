ui = navbarPage(title = 'Geometric Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_geometric_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('geofunc', class = 'ta-text'))),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('geoprops', class = 'ta-text'))))
