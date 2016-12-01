library(teachingApps)
library('plotly')
options('markdown.HTML.stylesheet' = global$css)

ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'MTBF Acceptance Test',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),
          
tabPanel(h4('Planning Tool'),
         fluidRow(teachingApps::insertUI('acceptance_testing_mtbf'))),

tabPanel(h4('How To Use The Tool'),
        mainPanel(uiOutput("howtomtbf", class = 'shiny-text-output'))),

tabPanel(h4('Examples'),
        mainPanel(uiOutput("examplemtbf", class = 'shiny-text-output'))),

tabPanel(h4('Background'),
        mainPanel(uiOutput("backgroundmtbf", class = 'shiny-text-output'))),

tabPanel(h4('About'),
        mainPanel(uiOutput("aboutmtbf", class = 'shiny-text-output'))))

