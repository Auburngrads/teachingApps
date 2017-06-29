ui = navbarPage(title = 'Normal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_stamp(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::add_ui('distribution_normal'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('norfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('norprops', class = 'shiny-text-output'))))
