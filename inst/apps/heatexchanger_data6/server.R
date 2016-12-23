server = function(input, output, session) {
  
output$table.heat <- DT::renderDataTable({ 
  
  DT::datatable(HeatExchanger.ld, options = list(pageLength = 10)) })

output$summary.heat <- renderPrint({ 
  
  summary(HeatExchanger.ld)                        })

output$eventplot.heat <- renderPlot({ 

    par(family = "serif",font = 2)
  
  if (input$PLOT_4 == "Event Plot") event.plot(HeatExchanger.ld) 
  
  if (input$PLOT_4 == "Histogram") hist(Response(HeatExchanger.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(HeatExchanger.ld,"time.units"))})

output$cdfplot.heat <- renderPlot({ 
  
  par(family = "serif", font = 2)
  
  plot(HeatExchanger.ld, 
       distribution = input$DIST_4, 
       conf.level = as.numeric(input$CI_4), 
       band.type = input$BT_4) 
})
}