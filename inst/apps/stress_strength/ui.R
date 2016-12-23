library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),  
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),

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
