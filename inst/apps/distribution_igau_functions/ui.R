ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),

sidebarLayout(
  sidebarPanel(width = 3, 
  hr(),
  sliderInput("rangeigau", 
              label = "Range",
              min =  0, 
              max = 50, 
              value = c(0,25)),
  hr(),
  sliderInput("th.igau", 
              label = h2(HTML("Scale (&theta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1, 
              animate = TRUE),
  hr(),
  sliderInput("be.igau", 
              label = h2(HTML("Shape (&beta;)")),
              min = .5, 
              max = 10, 
              step = .5, 
              value = 1,
              animate = TRUE)),

mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel('Distribution Function',metricsgraphicsOutput("igauC",height = "600px")),
  tabPanel('Density',              metricsgraphicsOutput("igauP",height = "600px")),
  tabPanel('Survival',             metricsgraphicsOutput("igauR",height = "600px")),
  tabPanel('Hazard',               metricsgraphicsOutput("igauh",height = "600px")),
  tabPanel('Cumulative Hazard',    metricsgraphicsOutput("igauH",height = "600px")),
  tabPanel('Quantile',             metricsgraphicsOutput("igauQ",height = "600px"))
  ))))
