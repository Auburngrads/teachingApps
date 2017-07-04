ui = navbarPage(title = 'Normal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_normal_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('norfunc', class = 'ta-text'))),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('norprops', class = 'ta-text'))))
