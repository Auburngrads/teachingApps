ui = navbarPage(title = 'Lognormal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_lognormal_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('lnorfunc'), class = 'shiny-text-output')),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('lnorprops', class = 'shiny-text-output'))))
