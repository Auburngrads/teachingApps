library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("CSS"))),
               tags$head(includeCSS("www/custom.css")),
               tags$footer(getShinyOption("sign")),
               
sidebarLayout(
  sidebarPanel(width = 3,
    selectInput("censor", 
                label = h2("Type of Censoring"),
                choices = c("Exact Failures", 
                            "Singly Censored", 
                            "Inspection Data"),
                 selected = "Exact Failures")),
  
    mainPanel(plotOutput("plotcens", height = "200px"), width = 9)))
