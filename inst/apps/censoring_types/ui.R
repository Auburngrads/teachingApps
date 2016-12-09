library(teachingApps)

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOptions("theme")), 
                 tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),         sidebarLayout(
                   
sidebarPanel(width = 3,
  selectInput("censor", 
              label = h2("Type of Censoring"),
              choices = c("Exact Failures", 
                          "Singly Censored", 
                          "Inspection Data"),
              selected = "Exact Failures")),
  
  mainPanel(plotOutput("plotcens", height = "200px"), width = 9)),

if(!getShinyOptions("story"))
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
