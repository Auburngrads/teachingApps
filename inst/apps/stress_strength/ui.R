ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),

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
