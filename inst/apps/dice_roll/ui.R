library(teachingApps)
library(DT)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS("www/custom.css")), 
               tags$footer(getShinyOption("sign")),
              
sidebarLayout(
   sidebarPanel(width = 3,
      selectInput('rv.func', 
                  label = h2('Random Variable'),
                  choices = c('Sum of Rolls', 
                              'Product of Rolls', 
                              'Difference of Rolls'), 
                  selected = 'Sum of Rolls'),
       sliderInput('no.dice', 
                   label = h2('Number Of Rolls'), 
                   min = 1, 
                   max = 4, 
                   value = 1),
       sliderInput('no.sides', 
                   label = h2('Number Of Sides'), 
                   min = 4, 
                   max = 20, 
                   value = 6)),
         
mainPanel(width = 9,
    tabsetPanel(type = 'pills',
          tabPanel(h4("Outcomes"), 
                   DT::dataTableOutput("results", height = "550px")),
          tabPanel(h4('Borel Algegra'),
                   plotOutput('diceresults', height = '550px')),
          tabPanel(h4('Probabilities'),
                   plotOutput('diceprobs', height = '550px'))))))
