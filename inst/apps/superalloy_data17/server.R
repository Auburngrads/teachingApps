server = function(input, output, session) {

    par(family = "serif", font = 2)
           
  output$summary2 <- renderPrint({ summary(superalloy.ld)                        
})

  output$table2 <- DT::renderDataTable({ DT::datatable(superalloy.ld,
                                                       options = list(pageLength = 8)) 
})

  output$eventplot2 <- renderPlot({ 
  
  if (input$PLOT2 == "Event Plot") event.plot(superalloy.ld) 
  
  if (input$PLOT2 == "Histogram") hist(Response(superalloy.ld), 
                                      probability = TRUE, 
                                      col = 1, 
                                      border = "white", 
                                      main = "", 
                                      xlab = attr(superalloy.ld,"time.units"))
})

  output$cdfplot2 <- renderPlot({ 
  
  plot(superalloy.ld, 
       distribution = input$dist2, 
       conf.level = as.numeric(input$ci2), 
       band.type = input$bt2) 
})
  
output$mleplot <- renderPlot({ 

  if (input$mleplot == "CDF Plot") mleprobplot(superalloy.ld, 
                                               distribution = input$mledist, 
                                               param.loc = input$paramloc ) 
  
  if (input$mleplot == "Hazard Plot") mlehazplot(superalloy.ld, 
                                                 distribution = input$mledist,
                                                 param.loc = input$paramloc) 
})
}