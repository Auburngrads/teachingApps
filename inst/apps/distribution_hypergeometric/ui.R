library(teachingApps)
library("metricsgraphics")

ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
sidebarLayout(
  sidebarPanel(width = 3, 
    sliderInput("m.hyp", 
                label = h2("Number of Success States (m)"),
                min = .05, 
                max = 1, 
                step=.05, 
                value = .05,
                animate = TRUE),
    sliderInput("n.hyp", 
                label = h2("Number of Failure States (n)"),
                min = 0, 
                max = 50, 
                step = 1,
                value = 2),
    sliderInput("k.hyp", 
                label = h2("Number of draws (k)"),
                min = .05, 
                max = 1, 
                step = .05, 
                value = .05,
                animate = TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("hypC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("hypP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("hypR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("hyph", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("hypH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("hypQ", height = "600px")))
))) 
