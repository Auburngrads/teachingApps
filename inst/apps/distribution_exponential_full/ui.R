ui = navbarPage(title = 'Exponential Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),


tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_exponential'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('expfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('expprops', class = 'shiny-text-output'))))
