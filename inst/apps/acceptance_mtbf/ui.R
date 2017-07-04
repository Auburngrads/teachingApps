ui = navbarPage(title = 'MTBF Acceptance Test',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

tabPanel('Planning Tool',
      fluidRow(teachingApps::add_ui('acceptance_testing_mtbf'))),

tabPanel('How To Use The Tool',
      fluidRow(uiOutput("howtomtbf", 
                        class = 'shiny-text-output'))),

tabPanel('Examples',
      fluidRow(uiOutput("examplemtbf", 
                        class = 'shiny-text-output'))),

tabPanel('Background',
      fluidRow(uiOutput("backgroundmtbf", 
                        class = 'shiny-text-output'))),

tabPanel('About',
      fluidRow(uiOutput("aboutmtbf", 
                        class = 'shiny-text-output'))))

