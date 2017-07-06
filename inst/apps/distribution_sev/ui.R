ui = navbarPage(title = 'Smallest Extreme Value Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_sev_functions')),

tabPanel('Distribution Functions',
         uiOutput('sevfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('sevprops', class = 'ta-text')))
