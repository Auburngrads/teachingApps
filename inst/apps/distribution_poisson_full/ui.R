ui = navbarPage(title = 'Poisson Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_poisson'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('poifunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('poiprops', class = 'shiny-text-output'))))
