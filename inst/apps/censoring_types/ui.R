library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
                 tags$head(includeCSS(getShinyOption("css"))),         sidebarLayout(
                   
sidebarPanel(width = 3,
  selectInput("censor", 
              label = h2("Type of Censoring"),
              choices = c("Exact Failures", 
                          "Singly Censored", 
                          "Inspection Data"),
              selected = "Exact Failures")),
  
  mainPanel(plotOutput("plotcens", height = "200px"), width = 9)),

if(!getShinyOption("story"))
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
