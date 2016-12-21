library(teachingApps)
library("metricsgraphics")

ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOption("theme")), 
               tags$head(includeCSS(getShinyOption("css"))),
               tags$footer(getShinyOption("sign")),

               tags$footer(getShinyOption("sign")), 
               
sidebarLayout(
  sidebarPanel(width = 3, 
     hr(), 
     sliderInput("range.bin", 
                 label = h2("Range:"),
                 min = 0, 
                 max = 50, 
                 step = 1,
                 value = c(0,10)),
     hr(),
     sliderInput("n.bin", 
                 label = h2("Observations"),
                 min = 0, 
                 max = 50, 
                 step = 1, 
                 value = 5), 
     hr(), 
     sliderInput("prob.bin", 
                 label = h2("Probability"),
                 min = .05, 
                 max = 1, 
                 step=.05, 
                 value = .05,
                 animate=TRUE)), 

   mainPanel(width = 9, 
       tabsetPanel(type = "pills", 
             tabPanel(h4("Distribution Function"), 
                      metricsgraphicsOutput("binC", height = "600px")), 
             tabPanel(h4("Density"),
                      metricsgraphicsOutput("binP", height = "600px")), 
             tabPanel(h4("Survival"), 
                      metricsgraphicsOutput("binR", height = "600px")), 
             tabPanel(h4("Hazard"), 
                      metricsgraphicsOutput("binh", height = "600px")), 
             tabPanel(h4("Cumulative Hazard"), 
                      metricsgraphicsOutput("binH", height = "600px")),
             tabPanel(h4("Quantile"), 
                      metricsgraphicsOutput("binQ", height = "600px"))))), 

if(!getShinyOption("story"))
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
