library(teachingApps)
library('scales')


ui <- fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
              # tags$head(includeCSS(getShinyOption("CSS"))),
              # tags$head(includeCSS("www/custom.css")),
              # tags$footer(getShinyOption("sign")),
               
sidebarLayout(
  sidebarPanel(width = 4,
    selectInput('correct', 
                label = h2('True Distribution'), 
                choices = c('Green', 
                            'Blue', 
                            'Red'), 
                selected = 'Blue'),
    
    actionButton('mlesample',h4('sample 1'), width = '100%'),
    hr(),
    actionButton('mlesample10',h4('sample 10'), width = '100%'),
    hr(),
    actionButton('clear',h4('clear'), width = '100%')),
  
  mainPanel(plotOutput('plotmle', height = '650px'), width = 8)))

