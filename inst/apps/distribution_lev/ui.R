ui = navbarPage(title = 'Largest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_lev_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('levfunc'), class = 'shiny-text-output')),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('levprops', class = 'shiny-text-output'))))
