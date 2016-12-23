server = function(input, output, session) {

  output$summary2 <- renderPrint({ summary(ZelenCap.ld)})

  output$table2 <- DT::renderDataTable({ DT::datatable(ZelenCap.ld,
                                                       options = list(pageLength = 10)) })

  output$eventplot2 <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    if (input$PLOT2 == "Event Plot") event.plot(ZelenCap.ld) 
    if (input$PLOT2 == "Histogram")  hist(Response(ZelenCap.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(ZelenCap.ld,"time.units"))})

  output$cdfplot2 <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    plot(ZelenCap.ld, distribution = input$dist2, 
     conf.level = as.numeric(input$ci2), band.type = input$bt2) })
  
  output$mleplot <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    if (input$mleplot == "CDF Plot") mleprobplot(ZelenCap.ld, 
                                                 distribution = input$mledist, 
                                                 param.loc = input$paramloc ) 
    if (input$mleplot == "Hazard Plot") mlehazplot(ZelenCap.ld, 
                                                   distribution = input$mledist,
                                                   param.loc = input$paramloc)})

  output$altplot <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    if (input$altvar == "Non Constant") groupi.mleprobplot(ZelenCap.ld, 
                                                           distribution = input$altdist, 
                                                           group.var = c(1, 2))
    
    if (input$altvar == "Constant")     groupm.mleprobplot(ZelenCap.ld, 
                                                           distribution = input$altdist)
})
}