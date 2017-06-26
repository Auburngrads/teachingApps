ui = navbarPage(title = 'Smallest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
tabPanel(h4('Shiny App'),
         fluidRow(teachingApps::nestUI('distribution_sev'))),

tabPanel(h4('Distribution Functions'),
         fluidRow(uiOutput('sevfunc'), class = 'shiny-text-output')),

tabPanel(h4('Distribution Properties'),
         fluidRow(uiOutput('sevprops', class = 'shiny-text-output'))))
