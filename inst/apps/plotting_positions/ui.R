ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout(
  sidebarPanel(
    sliderInput("plotposn", 
                label = "Sample Size", 
                min = 5, 
                max = 100, 
                value = 5, 
                step = 5),
    hr(),
    checkboxGroupInput("plotpos",
                       label = "Plotting Position", 
                       choices = c("Hazen" = 1,
                                   "Median-Ranks" = 2,
                                   "Weibull"      = 3),
                       selected = NULL, 
                       inline = FALSE,
                       width = validateCssUnit("1000")),
    hr(),
    actionButton("takeSample.pp","Sample Data")),
      
    mainPanel(plotOutput("probplotcompare"))))
