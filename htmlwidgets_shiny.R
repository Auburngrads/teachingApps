htmlwidgets_shiny <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  library(dygraphs)
  library(leaflet)
  library(threejs)
  library(d3heatmap)
  library(parcoords)
  library(taucharts)
  library(htmlwidgets)

shinyApp(options = list(height = '800px', width = '100%'),
ui = navbarPage(theme = shinythemes::shinytheme('flatly'), 
                includeCSS('css/my-shiny.css'),
  tabPanel(h4("Dygraph"),
  sidebarLayout(
    sidebarPanel(width = 3,
      numericInput("months", label = h2(HTML("<b>Months to Predict</b>")), 
                   value = 72, min = 12, max = 144, step = 12),
      selectInput("interval", label = h2(HTML("<b>Prediction Interval</b>")),
                  choices = c("0.80", "0.90", "0.95", "0.99"),
                  selected = "0.95"),
      hr(),
      div(h2(HTML("<b>From: </b>")), h3(strong(textOutput("from", inline = TRUE)))),
      br(),
      div(h2(HTML("<b>To: </b>")), h3(strong(textOutput("to", inline = TRUE))))),
    
    mainPanel(dygraphs::dygraphOutput("dygraph", height = '650px'), width = 9))),
  
  tabPanel(h4("Leaflet"),
  fluidPage(
    mainPanel(leaflet::leafletOutput("leaflet", height = '650px'), width = 12))),
  
  tabPanel(h4("threejs"),
  fluidPage(
    mainPanel(threejs::globeOutput("threejs", height = '650px'), width = 12))),
  
  tabPanel(h4("parcoords"),
  fluidPage(fluidRow(
    column(parcoords::parcoordsOutput("parcoords", height = '650px'), width = 12)))),
  
  tabPanel(h4("taucharts"),
  fluidPage(
    mainPanel(taucharts::tauchartsOutput("taucharts", height = '650px'), width = 12))),
  
  tabPanel(h4("D3heatmap"),
  fluidPage(
    mainPanel(d3heatmapOutput("d3heatmap", height = '650px'), width = 12)))),

server = function(input, output, session) {
  
  predicted <- reactive({
    hw <- HoltWinters(ldeaths)
    predict(hw, n.ahead = input$months, 
            prediction.interval = TRUE,
            level = as.numeric(input$interval))
  })
  
  output$dygraph <- renderDygraph({
    dygraph(predicted(), main = "Predicted Deaths from Lung Disease (UK)/Month") %>%
      dySeries(c("lwr", "fit", "upr"), label = "Deaths")
  })
  
  output$from <- renderText({
    if (!is.null(input$dygraph_date_window))
      strftime(input$dygraph_date_window[[1]], "%d %b %Y")      
  })
  
  output$to <- renderText({
    if (!is.null(input$dygraph_date_window))
      strftime(input$dygraph_date_window[[2]], "%d %b %Y")
})
  
  output$leaflet <- renderLeaflet({
    
      leaflet() %>%
      addTiles() %>%  
      addMarkers(c(lng=-84.084253,-84.083084), lat=c(39.783018,39.782334), 
                 popup=c("We Are Here", "Ok, We're Really Here"))
})
  output$threejs <- renderGlobe({
    
     globejs(img = system.file('images/world.jpg', package = 'threejs'), atmosphere = TRUE, long=c(-84.084253,-84.083084), lat=c(39.783018,39.782334), value = 50)
})
  
  output$parcoords <- renderParcoords({
    
     library(dplyr)
    diamonds <- ggplot2::diamonds
dmd <- diamonds[sample(1:nrow(diamonds),1000),] %>%
  mutate( carat = cut(carat, breaks=c(0,1,2,3,4,5), right = T)) %>%
  select( carat, color, cut, clarity, depth, table, price,  x, y, z)
  parcoords(data = dmd,
    rownames = F # turn off rownames from the data.frame
    , brushMode = "1D-axes"
    , reorderable = T
    , queue = T
    , color = list(
      colorBy = "carat"
      ,colorScale = htmlwidgets::JS("d3.scale.category10()")),
    height = '650', width = '1650', margin = list(left=0, right=0))
})
  output$taucharts <- renderTaucharts({
    
    tauchart(mtcars) %>%
    tau_point("wt", "mpg", color="cyl") %>%
    tau_color_manual(c("blue", "maroon", "black")) %>%
    tau_tooltip() %>%
    tau_trendline()
})
  output$d3heatmap <- renderD3heatmap({
    
    d3heatmap(mtcars, scale = "column", colors = "Spectral")
})
})
}
