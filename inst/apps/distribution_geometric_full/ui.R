ui = navbarPage(title = 'Geometric Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_geometric'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('geofunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('geoprops', class = 'shiny-text-output'))))
