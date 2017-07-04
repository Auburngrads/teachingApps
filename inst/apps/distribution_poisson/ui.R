ui = navbarPage(title = 'Poisson Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_poisson_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('poifunc', class = 'ta-text'))),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('poiprops', class = 'ta-text'))))
