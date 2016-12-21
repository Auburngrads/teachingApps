library(teachingApps)
library('metricsgraphics')

ui = navbarPage(title = 'Poisson Distribution',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4('Shiny App'),
sidebarLayout(
  sidebarPanel(width = 3, 
hr(), 
sliderInput("range.pois", 
            label = h2("Range"),
            min = 0, 
            max = 50, 
            step = 1,
            value = c(0,10)),
hr(), 
sliderInput("lamb.pois", 
            label = h2("Lambda"),
            min = .5, 
            max = 10, 
            step=.5, 
            value = .5,
            animate=TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("poisC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("poisP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("poisR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("poish", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("poisH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("poisQ", height = "600px")))))),

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('poifunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('poiprops', class = 'shiny-text-output'), width = 12)))
