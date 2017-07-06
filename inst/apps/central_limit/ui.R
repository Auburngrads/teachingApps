ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout(
  sidebarPanel(
    selectInput("distribution", 
                label = "Distribution:",
                choices = c("Weibull",
                            "Exponential",
                            "Gamma",
                            "Normal",
                            "Lognormal",
                            "Uniform"),
                selected = "Uniform"),
  
    sliderInput("bins", 
                label = "Number of Bins:",
                min = 10, 
                max = 50, 
                value = 10, 
                step = 10),
  
    sliderInput("S", 
                label = "Sample Size:",
                min = 3, 
                max = 30, 
                value = 3, 
                step = 3,
                animate = T)), 
  
    mainPanel(plotOutput("CLT", height = "600px"  ))))
