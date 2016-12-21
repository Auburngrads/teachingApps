library(teachingApps)
library(shiny)
library('plotly')
options('markdown.HTML.stylesheet' = getShinyOption('css'))

ui = navbarPage(title = 'MTBF Acceptance Test',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption('theme')),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption('appName'))),
          
tabPanel(h4('Planning Tool'),
         fluidRow(teachingApps::insertUI('acceptance_testing_mtbf'))),

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

