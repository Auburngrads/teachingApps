ui = navbarPage(title = 'Largest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_stamp(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::add_ui('distribution_lev'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('levfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('levprops', class = 'shiny-text-output'))))
