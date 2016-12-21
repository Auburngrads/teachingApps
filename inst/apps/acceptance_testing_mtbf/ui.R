library(teachingApps)
library(plotly)

ui <- fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption('theme')), 
                tags$head(includeCSS(getShinyOption("css"))),

sidebarLayout(
    sidebarPanel(width = 3,
       sliderInput('ttt', h4('Available Test Time'), 
                    min = 100, 
                    max = 1000, 
                    step = 10, 
                    value = 400),
       sliderInput('fails', h4('Failures Allowed'), 
                    min = 0, 
                    max = 30, 
                    step = 1, 
                    value = 1),
       sliderInput('thresh', h4('Threshold MTBF'), 
                    min = 10, 
                    max = 500, 
                    step = 5, 
                    value = 40),
       sliderInput('objective', h4('Objective MTBF'), 
                    min = 10, 
                    max = 500, 
                    step = 5, 
                    value = 70),
       sliderInput('contract', h4('Contract MTBF'), 
                    min = 10, 
                    max = 500, 
                    step = 5, 
                    value = 90)),
  mainPanel(plotlyOutput('mtbf', height = '650px'),width = 9)))

