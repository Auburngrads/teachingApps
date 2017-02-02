library(teachingApps)
library(scales)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),

sidebarLayout(
   sidebarPanel(
      sliderInput(inputId = "n",
                  h2('Sample Size (n)'),
                  value = 10,
                  min = 2,
                  max = 50,
                  step = 1),
      sliderInput(inputId = "confLevel",
                  h2("Confidence Level"),
                  value = 80,
                  min = 50,
                  max = 99,
                  step = 1),
    actionButton("takeSample",h4("Sample Now"), width = '100%'),
    hr(),
    actionButton("reset",h4("Start Over"), width = '100%')),
 
 mainPanel(plotOutput('ciplot', height = '600px'))))
