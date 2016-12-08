library(teachingApps)
library('SMRD')

ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme), 
               tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("dist1", 
              label = h2("Distribution (Left)"),
              choices = c("Exponential",
                          "Normal",
                          "SEV",
                          "Logistic",
                          "LEV"), 
              selected = "SEV"),
  selectInput("axis1", 
              label = h2("Axis (Left)"),
              choices = c("True Axis",
                          "Transformed Axis"), 
              selected = "True Axis"),
  selectInput("dist2", 
              label = h2("Distribution (Right)"),
              choices = c("Exponential",
                          "Normal",
                          "SEV",
                          "Logistic",
                          "LEV"), 
              selected = "SEV"),
  selectInput("axis2", 
              label = h2("Axis (Right)"),
              choices = c("True Axis",
                          "Transformed Axis"), 
              selected = "Transformed Axis")),

mainPanel(plotOutput("compare", height = "600px"), width = 9)),

if(!global$story)
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
