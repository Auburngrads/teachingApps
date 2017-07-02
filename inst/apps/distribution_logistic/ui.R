ui = navbarPage(title = 'Logistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_stamp(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::add_ui('distribution_logistic'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('logfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('logprops', class = 'shiny-text-output'))))
