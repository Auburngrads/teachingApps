library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),
               
sidebarLayout(
  sidebarPanel(
    sliderInput("plotposn", 
                label = h2("Sample Size"), 
                min = 5, 
                max = 100, 
                value = 5, 
                step = 5),
    hr(),
    checkboxGroupInput("plotpos",
                       label = h2("Plotting Position"), 
                       choices = c("Hazen" = 1,
                                   "Median-Ranks" = 2,
                                   "Weibull"      = 3),
                       selected = NULL, 
                       inline = FALSE,
                       width = validateCssUnit("1000")),
    hr(),
    actionButton("takeSample.pp",h2("Sample Data"), width = '100%')),
      
    mainPanel(plotOutput("probplotcompare", height = '600px'))))
