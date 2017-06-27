ui = navbarPage(title = 'Loglogistic Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_loglogistic'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('llogfunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('llogprops', class = 'shiny-text-output'), width = 12)))
