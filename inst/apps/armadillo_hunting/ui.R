ui = navbarPage(title = 'Armadillo Hunting',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),


tabPanel('Overview',
      fluidRow(uiOutput("armadillo_overview", 
                           class = 'ta-text'))),
tabPanel('Planning Tool',
      fluidRow(teachingApps::add_ui('acceptance_testing_mtbf'))),

tabPanel('How To Use The Tool',
      fluidRow(uiOutput("howtomtbf", 
                           class = 'ta-text'))),

tabPanel('Examples',
      fluidRow(uiOutput("examplemtbf", 
                           class = 'ta-text'))),

tabPanel('Background',
      fluidRow(uiOutput("backgroundmtbf", 
                           class = 'ta-text'))),

tabPanel('About',
      fluidRow(uiOutput("aboutmtbf", 
                           class = 'ta-text'))))

