ui = navbarPage(title = 'Armadillo Hunting',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),


tabPanel(h4('Overview'),
         fluidRow(uiOutput("armadillo_overview", 
                           class = 'shiny-text-output'))),
tabPanel(h4('Planning Tool'),
         fluidRow(teachingApps::nestUI('acceptance_testing_mtbf'))),

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

