server = function(input, output, session) {
  
  predicted <- reactive({
    hw <- HoltWinters(datasets::ldeaths)
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
      addMarkers(c(lng=-84.309820,-84.311226), lat=c(39.350752,39.351341), 
                 popup=c("We Are Here", "Ok, We're Really Here"))
})
  output$threejs <- renderGlobe({
    
     globejs(img = system.file('images/world.jpg', package = 'threejs'), atmosphere = TRUE, long=c(-84.084253,-84.083084), lat=c(39.783018,39.782334), value = 50)
})
  
#   output$parcoords <- renderParcoords({
#     
#     diamonds <- diamonds
# dmd <- diamonds[sample(1:nrow(diamonds),1000),]
# dmd <- dplyr::mutate(.data = dmd, carat = cut(carat, breaks=c(0,1,2,3,4,5), right = T))
# dmd <- dplyr::select(.data = dmd, carat, color, cut, clarity, depth, table, price,  x, y, z)
#   parcoords(data = dmd,
#     rownames = F # turn off rownames from the data.frame
#     , brushMode = "1D-axes"
#     , reorderable = T
#     , queue = T
#     , color = list(
#       colorBy = "carat"
#       ,colorScale = htmlwidgets::JS("d3.scale.category10()")),
#     height = '650', width = '1650', margin = list(left=0, right=0))
# })
#   output$taucharts <- renderTaucharts({
#     
#     tauchart(datasets::mtcars) %>%
#     tau_point("wt", "mpg", color="cyl") %>%
#     tau_color_manual(c("blue", "maroon", "black")) %>%
#     tau_tooltip() %>%
#     tau_trendline()
# })
  output$d3heatmap <- renderD3heatmap({
    
    d3heatmap(datasets::mtcars, scale = "column", colors = "Spectral")
})
}