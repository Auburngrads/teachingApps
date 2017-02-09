library(teachingApps)
library(pos = 2,  package = 'metricsgraphics')
library(pos = 2,  package = 'dygraphs')
library(pos = 2,  package = 'leaflet')
library(pos = 2,  package = 'threejs')
library(pos = 2,  package = 'd3heatmap')
library(pos = 2,  package = 'parcoords')
library(pos = 2,  package = 'taucharts')
library(pos = 2,  package = 'htmlwidgets')
library(pos = 2,  package = 'plotly')

ui = navbarPage(title = 'htmlwidgets',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4("Dygraph"),
  sidebarLayout(
    sidebarPanel(width = 3,
      numericInput("months", 
                   label = h2(HTML("<b>Months to Predict</b>")), 
                   value = 72, 
                   min = 12, 
                   max = 144, 
                   step = 12),
      selectInput("interval", 
                  label = h2(HTML("<b>Prediction Interval</b>")),
                  choices = c("0.80", "0.90", "0.95", "0.99"),
                  selected = "0.95"),
      hr(),
      div(h2(HTML("<b>From: </b>")), h3(strong(textOutput("from", inline = TRUE)))),
      br(),
      div(h2(HTML("<b>To: </b>")), h3(strong(textOutput("to", inline = TRUE))))),
    
    mainPanel(dygraphOutput("dygraph", height = '650px'), width = 9))),
  
tabPanel(h4("Leaflet"),
  fluidPage(
    mainPanel(leafletOutput("leaflet", height = '650px'), width = 12))),
  
  tabPanel(h4("threejs"),
  fluidPage(
    mainPanel(globeOutput("threejs", height = '650px'), width = 12))),
  
  tabPanel(h4("parcoords"),
  fluidPage(fluidRow(
    column(parcoordsOutput("parcoords", height = '650px'), width = 12)))),
  
  tabPanel(h4("taucharts"),
  fluidPage(
    mainPanel(tauchartsOutput("taucharts", height = '650px'), width = 12))),
  
  tabPanel(h4("D3heatmap"),
  fluidPage(
    mainPanel(d3heatmapOutput("d3heatmap", height = '650px'), width = 12))),
  
  tabPanel(h4('Plotly'),
         sidebarLayout(
           sidebarPanel(width = 3,
             sliderInput('ttt', h4('Available Test Time'), 
                          min = 100, 
                          max = 1000, 
                          step = 10, 
                          value = 400),
             sliderInput('fails', h4('Failures Allowed'), 
                          min = 0, 
                          max = 30, 
                          step = 1, 
                          value = 1),
             sliderInput('thresh', h4('Threshold MTBF'), 
                          min = 10, 
                          max = 500, 
                          step = 5, 
                          value = 40),
             sliderInput('objective', h4('Objective MTBF'), 
                          min = 10, 
                          max = 500, 
                          step = 5, 
                          value = 70),
             sliderInput('contract', h4('Contract MTBF'), 
                          min = 10, 
                          max = 500, 
                          step = 5, 
                          value = 90)),
           mainPanel(plotlyOutput('mtbf', height = '650px'),width = 9))))
