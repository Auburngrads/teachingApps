ui = navbarPage(title = 'Confidence Intervals',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

tabPanel('Background',
         uiOutput('ci_intro', class = 'ta-text')),

tabPanel("Simulation",
         add_ui('confidence_intervals_simulation')))
