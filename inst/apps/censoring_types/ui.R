ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
sidebarLayout(
  sidebarPanel(width = 3,
    selectInput("censor", 
                label = h2("Type of Censoring"),
                choices = c("Exact Failures", 
                            "Singly Censored", 
                            "Inspection Data"),
                 selected = "Exact Failures")),
  
    mainPanel(plotOutput("plotcens", height = "200px"), width = 9)))
