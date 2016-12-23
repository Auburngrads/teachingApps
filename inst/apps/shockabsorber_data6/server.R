server = function(input, output, session) {
  
output$table.shock <- DT::renderDataTable({ 
  
  DT::datatable(ShockAbsorber.ld, options = list(pageLength = 10)) })

output$summary.shock <- renderPrint({ 
  
  summary(ShockAbsorber.ld)                        })

output$eventplot.shock <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_3 == "Event Plot") event.plot(ShockAbsorber.ld) 
  if (input$PLOT_3 == "Histogram") hist(Response(ShockAbsorber.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(ShockAbsorber.ld,"time.units"))})

output$cdfplot.shock <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(ShockAbsorber.ld, distribution = input$DIST_3, 
     conf.level = as.numeric(input$CI_3), band.type = input$BT_3) 
})
}