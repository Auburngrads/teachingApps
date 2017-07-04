ui = navbarPage(title = 'Logistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_logistic_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('logfunc'), class = 'shiny-text-output')),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('logprops', class = 'shiny-text-output'))))
