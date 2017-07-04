ui = navbarPage(title = 'Exponential Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),


tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_exponential_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('expfunc', class = 'ta-text'))),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('expprops', class = 'ta-text'))))
