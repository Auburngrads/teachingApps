library(teachingApps)
library(scales)

         
ui = navbarPage(title = 'Power Calculator',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4('Normal-Normal'),
   sidebarLayout(
   sidebarPanel(width = 3,
      sliderInput('norm1.1', 
                  label = h2(HTML('Mean - &mu;<sub>1</sub>')), 
                  min = 4,
                  max = 30,
                  step = 1,
                  value = 12),
      sliderInput('norm1.2', 
                  label = h2(HTML('Std Dev - &sigma;<sub>1</sub>')), 
                  min = 1,
                  max = 10,
                  step = .5,
                  value = 4 ),
      sliderInput('norm2.1', 
                  label = h2(HTML('<red>Mean - &#x3BC;<sub>2</sub></red>')), 
                  min = 3,
                  max = 30,
                  step = 1,
                  value = 20),
      sliderInput('norm2.2', 
                  label = h2(HTML('<red>Std Dev - &sigma;<sub>2</sub></red>')), 
                  min = 1,
                  max = 10,
                  step = .5,
                  value = 5 )),
                          
                mainPanel(plotOutput('nor.nor', height = '625px'), width = 9))))
