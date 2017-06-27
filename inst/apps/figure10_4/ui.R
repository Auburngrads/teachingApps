library(teachingApps)
library('SMRD')

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),

sidebarLayout(
  sidebarPanel(width = 3,
    sliderInput("n"  , 
                label = h2("Sample Size"),
                min = 5, 
                max = 200, 
                value = 5, 
                step = 20, 
                animate = TRUE),
    sliderInput("sim", 
                label = h2("Number Simulations"),
                min = 5, 
                max = 50, 
                value = 5, 
                step = 5, 
                animate = TRUE),
    selectInput("dis", 
                label = h2("Distribution"),
                choices = c("Weibull","Lognormal"), 
                selected = "Weibull")),
  
  mainPanel(plotOutput('simulate', height = '600px'), width = 9)))
