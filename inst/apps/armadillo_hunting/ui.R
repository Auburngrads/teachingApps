ui = navbarPage(title = 'Armadillo Hunting',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_stamp(),


tabPanel(h4('Overview'),
         fluidRow(uiOutput("armadillo_overview", 
                           class = 'shiny-text-output'))),
tabPanel(h4('Planning Tool'),
         fluidRow(teachingApps::add_ui('acceptance_testing_mtbf'))),

tabPanel(h4('How To Use The Tool'),
         fluidRow(uiOutput("howtomtbf", 
                           class = 'shiny-text-output'))),

tabPanel(h4('Examples'),
         fluidRow(uiOutput("examplemtbf", 
                           class = 'shiny-text-output'))),

tabPanel(h4('Background'),
         fluidRow(uiOutput("backgroundmtbf", 
                           class = 'shiny-text-output'))),

tabPanel(h4('About'),
         fluidRow(uiOutput("aboutmtbf", 
                           class = 'shiny-text-output'))))

