ui = navbarPage(title = 'Weibull Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_weibull'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('weibfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('weibprops', class = 'shiny-text-output'))))
