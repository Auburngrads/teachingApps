ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),

sidebarLayout(
   sidebarPanel(
      sliderInput("mean", 
                  label = "Applied Stress:",
                  min = 5, 
                  max = 16, 
                  value = 5, 
                  step = 1, 
                  animate=TRUE)),
    
    mainPanel(plotOutput("first", height = "300px"))))
