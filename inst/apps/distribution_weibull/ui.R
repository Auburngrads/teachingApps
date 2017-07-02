ui = navbarPage(title = 'Weibull Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_stamp(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::add_ui('distribution_weibull'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('weibfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('weibprops', class = 'shiny-text-output'))))
