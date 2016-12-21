library(teachingApps)
library('metricsgraphics')
library('SMRD')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                tags$head(includeCSS(getShinyOption("css"))),
               
sidebarLayout(
  sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.s", 
              label = h2("Range"),
              min = -20, 
              max = 20, 
              value = c(-6,6)),
  hr(),
  sliderInput("mu.sev", 
              label = h2(HTML("Mean (&mu;)")),
              min = -3, 
              max = 3, 
              step = 0.5, 
              value = 0, 
              animate = T),
  hr(),
  sliderInput("sig.sev", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 1, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("sevC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("sevP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("sevR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("sevh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("sevH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("sevQ",height = "600px"))))))