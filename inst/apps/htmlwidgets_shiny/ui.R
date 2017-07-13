ui = navbarPage(title = 'htmlwidgets & shiny',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),

                
tabPanel("Dygraph",
  sidebarLayout(
    sidebarPanel(width = 3,
      numericInput("months", 
                   label = "Months to Predict", 
                   value = 72, 
                   min = 12, 
                   max = 144, 
                   step = 12),
      selectInput("interval", 
                  label = "Prediction Interval",
                  choices = c("0.80", "0.90", "0.95", "0.99"),
                  selected = "0.95"),
      hr(),
      div("From: ", strong(textOutput("from", inline = TRUE))),
      br(),
      div("To: ", strong(textOutput("to", inline = TRUE))))),
    
    mainPanel(dygraphOutput("dygraph", height = '650px'), width = 9)),
  
tabPanel("Leaflet",
  fluidPage(
    mainPanel(leafletOutput("leaflet", height = '650px'), width = 12))),
  
  tabPanel("threejs",
  fluidPage(
    mainPanel(globeOutput("threejs", height = '650px'), width = 12))),
  
  # tabPanel("parcoords",
  # fluidPage(fluidRow(
  #   column(parcoordsOutput("parcoords", height = '650px'), width = 12)))),
  # 
  # tabPanel("taucharts",
  # fluidPage(
  #   mainPanel(tauchartsOutput("taucharts", height = '650px'), width = 12))),
  
  tabPanel("D3heatmap",
  fluidPage(
    mainPanel(d3heatmapOutput("d3heatmap", height = '650px'), width = 12))))