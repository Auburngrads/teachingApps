ui = navbarPage(title = 'MTBF Acceptance Test',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

tabPanel('Planning Tool',
         add_ui('acceptance_testing_mtbf')),

tabPanel('How To Use The Tool',
         uiOutput("howtomtbf", class = 'ta-text')),

tabPanel('Examples',
         uiOutput("examplemtbf", class = 'ta-text')),

tabPanel('Background',
         uiOutput("backgroundmtbf", class = 'ta-text')),

tabPanel('About',
         uiOutput("aboutmtbf", class = 'ta-text')))

