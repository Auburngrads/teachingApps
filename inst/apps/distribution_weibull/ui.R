ui = navbarPage(title = 'Weibull Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_weibull_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('weibfunc', class = 'ta-text'))),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('weibprops', class = 'ta-text'))))
