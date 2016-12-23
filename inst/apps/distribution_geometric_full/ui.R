library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Geometric Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
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
            step=.05, 
            value = .05,
            animate=TRUE)), 

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
                   metricsgraphicsOutput("geomQ", height = "600px")))))), 

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('geofunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('geoprops', class = 'shiny-text-output'), width = 12)))
