library(teachingApps)
library('metricsgraphics')

ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
sidebarLayout(
  sidebarPanel(width = 3,
  hr(),
  sliderInput("range.ln", 
              label = h2("Range:"),
              min = 0, 
              max = 50, 
              value = c(0,20)),
  hr(),
  sliderInput("mu.ln", 
              label = h2(HTML("Log[Mean] (ln[&mu;])")),
              min = 0, 
              max = 10, 
              step = 0.5, 
              value = 4, 
              animate = T),
  hr(),
  sliderInput("sig.ln", 
              label = h2(HTML("log[Std Dev] (ln[&sigma;])")),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = T)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),  metricsgraphicsOutput("lnorC",height = "600px")),
  tabPanel(h4('Density'),                metricsgraphicsOutput("lnorP",height = "600px")),
  tabPanel(h4('Survival'),               metricsgraphicsOutput("lnorR",height = "600px")),
  tabPanel(h4('Hazard'),                 metricsgraphicsOutput("lnorh",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),      metricsgraphicsOutput("lnorH",height = "600px")),
  tabPanel(h4('Quantile'),               metricsgraphicsOutput("lnorQ",height = "600px"))))))
