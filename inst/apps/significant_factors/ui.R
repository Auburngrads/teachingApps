library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               #tags$head(includeCSS(getShinyOption("CSS"))),
               #tags$head(includeCSS("www/custom.css")),
               #tags$footer(getShinyOption("sign")),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     selectInput('response',
                 h4('Choose Response'),
                 choices = colnames(mtcars2),
                 selectize = T),
     
     htmlOutput('factors')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)))
