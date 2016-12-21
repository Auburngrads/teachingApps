server = function(input, output, session) {
  
output$table.turb <- DT::renderDataTable({ DT::datatable(Turbine.ld,
                                                          options = list(pageLength = 10)) })

output$summary.turb <- renderPrint({ summary(Turbine.ld)                        })

output$eventplot.turb <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_5 == "Event Plot") event.plot(Turbine.ld) 
  if (input$PLOT_5 == "Histogram") hist(Response(Turbine.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Turbine.ld,"time.units"))})

output$cdfplot.turb <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Turbine.ld, distribution = input$DIST_5, 
     conf.level = as.numeric(input$CI_5), band.type = input$BT_5) 
})
}