ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout(
  sidebarPanel(width = 3,
    selectInput("censor", 
                label = "Type of Censoring",
                choices = c("Exact Failures", 
                            "Singly Censored", 
                            "Inspection Data"),
                selected = "Exact Failures")),
  
    mainPanel(plotOutput("plotcens", height = "200px"), width = 9)))
