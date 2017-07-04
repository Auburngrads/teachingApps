ui = navbarPage(title = 'Beta Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_beta_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('betafunc'), class = 'shiny-text-output')),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('betaprops', class = 'shiny-text-output'))))
