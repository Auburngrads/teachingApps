library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
               tags$head(includeCSS("www/custom.css")),
               tags$footer(getShinyOption('sign')),
               
sidebarLayout(
  sidebarPanel(
    selectInput("distribution", 
                label = h4("Distribution:"),
                choices = c("Weibull",
                            "Exponential",
                            "Gamma",
                            "Normal",
                            "Lognormal",
                            "Uniform"),
                selected = "Uniform"),
  
    sliderInput("bins", 
                label = h4("Number of Bins:"),
                min = 10, 
                max = 50, 
                value = 10, 
                step = 10),
  
    sliderInput("S", 
                label = h4("Sample Size:"),
                min = 3, 
                max = 30, 
                value = 3, 
                step = 3,
                animate = T)), 
  
    mainPanel(plotOutput("CLT", height = "600px"  ))))
