library(teachingApps)
library("metricsgraphics")

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),

               tags$footer(getShinyOption("sign")), 
               
sidebarLayout(
  sidebarPanel(width = 3, 
  hr(), 
  sliderInput("range.geom", 
              label = h2("Range"),
              min = 0, 
              max = 50, 
              step = 1,
              value = c(0,10)),
  hr(), 
  sliderInput("prob.geom", 
              label = h2("Probability"),
              min = .05, 
              max = 1, 
              step = .05, 
              value = .05,
              animate = TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("geomC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("geomP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("geomR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("geomh", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("geomH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("geomQ", height = "600px")))
))) 
