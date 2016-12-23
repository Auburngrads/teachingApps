library(teachingApps)
library('metricsgraphics')
library('SMRD')

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),

sidebarLayout(
  sidebarPanel(width = 3, 
  hr(),
  sliderInput("range.lev", 
              label = h2("Range"),
              min = -20, 
              max = 20, 
              value = c(-6,6)),
  hr(),
  sliderInput("mu.lev", 
              label = h2(HTML("Mean (&mu;)")),
              min = -3, 
              max = 3, 
              step = 0.5, 
              value = 0, 
              animate = T),
  hr(),
  sliderInput("sig.lev", 
              label = h2(HTML("Std Dev (&sigma;)")),
              min = 1, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput('levC',height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput('levP',height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput('levR',height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput('levh',height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput('levH',height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput('levQ',height = "600px"))))))
