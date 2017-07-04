ui = navbarPage(title = 'Loglogistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel('Shiny App',
      fluidRow(teachingApps::add_ui('distribution_loglogistic_functions'))),

tabPanel('Distribution Functions',
      fluidRow(uiOutput('llogfunc'), class = 'shiny-text-output', width = 12)),

tabPanel('Distribution Properties',
      fluidRow(uiOutput('llogprops', class = 'shiny-text-output'), width = 12)))
