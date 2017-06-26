ui = navbarPage(title = 'Normal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_normal'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('norfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('norprops', class = 'shiny-text-output'))))
