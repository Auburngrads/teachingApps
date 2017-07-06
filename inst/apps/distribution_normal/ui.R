ui = navbarPage(title = 'Normal Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Shiny App',
      add_ui('distribution_normal_functions')),

tabPanel('Distribution Functions',
         uiOutput('norfunc', class = 'ta-text')),

tabPanel('Distribution Properties',
         uiOutput('norprops', class = 'ta-text')))
