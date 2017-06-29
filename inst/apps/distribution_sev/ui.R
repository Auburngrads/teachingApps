ui = navbarPage(title = 'Smallest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_stamp(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::add_ui('distribution_sev'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('sevfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('sevprops', class = 'shiny-text-output'))))
