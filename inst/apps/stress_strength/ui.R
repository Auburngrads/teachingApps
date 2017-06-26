ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),

sidebarLayout(
   sidebarPanel(
      sliderInput("mean", 
                  label = h2("Applied Stress:"),
                  min = 5, 
                  max = 16, 
                  value = 5, 
                  step = 1, 
                  animate=TRUE)),
    
    mainPanel(plotOutput("first", height = "300px"))))
