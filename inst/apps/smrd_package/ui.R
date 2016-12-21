library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'R Package: SMRD',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4('Background'),
         mainPanel(uiOutput('smrd.back'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Features'),
         mainPanel(uiOutput('smrd.feat'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Data Sets"), DT::dataTableOutput("smrd.data", height = "600px")),

tabPanel(h4('Vignettes'),
         mainPanel(uiOutput('smrd.vign'), class = 'shiny-text-output', width = 12)))
