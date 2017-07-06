ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout(
  sidebarPanel(
    sliderInput("mean", 
                label = "Mean:",
                min = 0,
                max = 4,
                step = 0.1,
                value = 2),
  
    sliderInput("sd", 
                label = "Standard Deviation:",
                min = 0.25, 
                max = 2.5, 
                value = 1, 
                step = 0.1),
  
    sliderInput("crit", 
                label = "Critical Value:",
                min = 2, 
                max = 6, 
                value = 3, 
                step = 0.1,
                animate = animationOptions(interval = 250, loop = T))), 
  
    mainPanel(plotOutput("output1", height = "600px"  ))))
