library(teachingApps)
library(scales)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS(getShinyOption("CSS"))),
               tags$head(includeCSS("www/custom.css")),
               tags$footer(getShinyOption("sign")),
               
inputPanel(
  selectInput('dist1', h2('Distro 1'), choices = c('Normal'), selected = 'Normal'),
  selectInput('dist2', h2('Distro 2'), choices = c('Normal'), selected = 'Normal')),
      
fluidRow(
  column(width = 2,
     sliderInput('normal1.1', 
                 label = h2(HTML('Mean - &mu;<sub>1</sub>')), 
                 min = 4,
                 max = 30,
                 step = 1,
                 value = 12),
     sliderInput('normal1.2', 
                 label = h2(HTML('Std Dev - &sigma;<sub>1</sub>')), 
                 min = 1,
                 max = 10,
                 step = .5,
                 value = 4 )),
      
  column(width = 2,
     sliderInput('normal2.1', 
                 label = h2(HTML('<red>Mean - &#x3BC;<sub>2</sub></red>')), 
                 min = 3,
                 max = 30,
                 step = 1,
                 value = 20),
     sliderInput('normal2.2', 
                 label = h2(HTML('<red>Std Dev - &sigma;<sub>2</sub></red>')), 
                 min = 1,
                 max = 10,
                 step = .5,
                 value = 5 )),
    
   column(width = 8, plotOutput('cross', height = '550px'))))
