server = function(input, output, session) {

observe({
  
  if(input$mleplot=='Compare CDF Plots') {
    
  output$compare <- renderUI({
    
    
selectInput("mlecomp", label = h2("Compare Distribution"),
                      choices = c("Weibull",
                                  "Exponential",
                                  "Normal",
                                  "Lognormal",                      
                                  "Smallest Extreme Value",
                                  "Largest Extreme Value",
                                  "Frechet"), 
                      selected = "Lognormal")
})
  
  } else { output$compare <- renderUI({

selectInput("cimle2",   
            label = h2(HTML("<b>Confidence Level:</b>")),
            choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
            selected = 0.95) 
}) 
}
  
  if(input$PLOT2 == 'Histogram') {
    
    output$breaks <- renderUI({
      
      sliderInput('histbreaks', 
                  h2('Number of Bins'), 
                  min = 5, 
                  max = 50, 
                  step = 5, 
                  value = 5)
}) 
} else { output$breaks <- renderUI({NULL }) }
})
  
  output$summary2 <- renderPrint({ summary(ZelenCap.ld)                        
})
  output$table2 <- DT::renderDataTable({ DT::datatable(ZelenCap.ld,options =    
                                                         list(pageLength = 10)) 
})
  output$eventplot2 <- renderPlot({ 
  par(family = "serif",font = 2)
  if (input$PLOT2 == "Event Plot") event.plot(ZelenCap.ld) 
  if (input$PLOT2 == "Histogram") hist(Response(ZelenCap.ld), 
                                      probability = TRUE, 
                                      col = 1, 
                                      border = "white", 
                                      main = "", 
                                      xlab = attr(ZelenCap.ld,"time.units"),
                                      breaks = input$histbreaks,
                                      las = 1)
})
  output$cdfplot2 <- renderPlot({ 
  par(family = "serif", font = 2)
  plot(ZelenCap.ld, 
       distribution = input$dist2, 
       conf.level = as.numeric(input$ci2), 
       band.type = input$bt2) 
})
  output$mleplot <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$mleplot == "CDF Plot") mleprobplot(ZelenCap.ld, 
                                               distribution = input$mledist, 
                                               conf.level = as.numeric(input$cimle2),
                                               param.loc = input$paramloc) 
  if (input$mleplot == "Hazard Plot") mlehazplot(ZelenCap.ld, 
                                                 distribution = input$mledist,
                                                 conf.level = as.numeric(input$cimle2),
                                                 param.loc = input$paramloc)
  if (input$mleplot == "Compare CDF Plots") 
    compare.mleprobplot(ZelenCap.ld, 
                        main.distribution = input$mledist, 
                        compare.distribution = ifelse(is.null(input$mlecomp),
                                                      'Lognormal', 
                                                      input$mlecomp))
})
  output$altplot <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$altvar == "Non Constant") groupi.mleprobplot(ZelenCap.ld, 
                                                         distribution = input$altdist,
                                                         group.var = c(1, 2))   
  if (input$altvar == "Constant")     groupm.mleprobplot(ZelenCap.ld, 
                                                         distribution = input$altdist)
})
}