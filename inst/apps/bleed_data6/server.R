
server = function(input, output, session) {

output$table.bleed <- DT::renderDataTable({ DT::datatable(Bleed.ld,
                                                          options = list(pageLength = 10)) })

output$summary.bleed   <- renderPrint({ summary(Bleed.ld)                      })
output$summary.bleed.d <- renderPrint({ summary(Bleed.Dbase.ld)                })
output$summary.bleed.o <- renderPrint({ summary(Bleed.Otherbase.ld)            })


output$eventplot.bleed <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$PLOT_6 == "Event Plot") event.plot(Bleed.ld) 
  if (input$PLOT_6 == "Histogram") hist(Response(Bleed.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Bleed.ld,"time.units"))
})
output$eventplot.bleed.d <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$PLOT_6 == "Event Plot") event.plot(Bleed.Dbase.ld) 
  if (input$PLOT_6 == "Histogram") hist(Response(Bleed.Dbase.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Bleed.ld,"time.units"))
})
output$eventplot.bleed.o <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$PLOT_6 == "Event Plot") event.plot(Bleed.Otherbase.ld) 
  if (input$PLOT_6 == "Histogram") hist(Response(Bleed.Otherbase.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Bleed.ld,"time.units"))
})
output$cdfplot.bleed <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Bleed.ld, distribution = input$DIST_6, 
     conf.level = as.numeric(input$CI_6), band.type = input$BT_6) 
})
output$cdfplot.bleed.d <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Bleed.Dbase.ld, distribution = input$DIST_6, 
     conf.level = as.numeric(input$CI_6), band.type = input$BT_6) 
})
output$cdfplot.bleed.o <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Bleed.Otherbase.ld, distribution = input$DIST_6, 
     conf.level = as.numeric(input$CI_6), band.type = input$BT_6) 
})
output$figures.bleed <- codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r',
"
Bleed.ld <- frame.to.ld(SMRD::bleed,
                        response.column = 1, 
                        censor.column = 2, 
                        case.weight.column = 3,
                        x.columns = c(4),
                        data.title = 'Bleed Failure Data',
                        time.units = 'Hours')
stressor.ld(Bleed.ld, stress.var = 'D', print = FALSE)
stressor.ld(Bleed.ld, stress.var = 'Other')")
  
})
}
