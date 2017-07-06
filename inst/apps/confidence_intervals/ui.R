ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),

sidebarLayout(
   sidebarPanel(
      sliderInput(inputId = "n",
                  'Sample Size (n)',
                  value = 10,
                  min = 2,
                  max = 50,
                  step = 1),
      sliderInput(inputId = "confLevel",
                  "Confidence Level",
                  value = 80,
                  min = 50,
                  max = 99,
                  step = 1),
    actionButton("takeSample","Sample Now", width = '100%'),
    hr(),
    actionButton("reset","Start Over", width = '100%')),
 
 mainPanel(plotOutput('ciplot', height = '600px'))))
