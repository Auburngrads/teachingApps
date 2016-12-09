library(teachingApps)
library('SMRD')
library('metricsgraphics')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOptions("theme")),
               tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
               
sidebarLayout(
   sidebarPanel(width = 3,
      hr(),
      sliderInput("rangebisa", 
                  label = h2("Range"),
                  min = 0, 
                  max = 20, 
                  value = c(0,4)),
      hr(),
      sliderInput("be.bisa", 
                  label = h2(HTML("Shape (&beta;)")),
                  min = 0.5, 
                  max = 10, 
                  step = 0.5, 
                  value = 1, 
                  animate = TRUE),
      hr(),
      sliderInput("th.bisa", 
                  label = h2(HTML("Scale (&theta;)")),
                  min = 0.5, 
                  max = 10, 
                  step = 0.5, 
                  value = 1,
                  animate = TRUE)),

  mainPanel(width = 9,
    tabsetPanel(type = 'pills',
      tabPanel(h4('Distribution Function'),
               metricsgraphicsOutput("bisaC",height = "600px")),
      tabPanel(h4('Density'),              
               metricsgraphicsOutput("bisaP",height = "600px")),
      tabPanel(h4('Survival'),
               metricsgraphicsOutput("bisaR",height = "600px")),
      tabPanel(h4('Hazard'),
               metricsgraphicsOutput("bisah",height = "600px")),
      tabPanel(h4('Cumulative Hazard'),
               metricsgraphicsOutput("bisaH",height = "600px")),
      tabPanel(h4('Quantile'),
               metricsgraphicsOutput("bisaQ",height = "600px"))))),

if(!getShinyOptions("story"))
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
