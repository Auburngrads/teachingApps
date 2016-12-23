
server = function(input, output, session) {

  par(family = "serif",font = 2)
  at7987.ld <- frame.to.ld(SMRD::at7987,
                           response.column = 1,
                           censor.column = 2,
                           case.weight.column = 3,
                           time.units = "Kilocycles")
    
output$table.at7987 <- DT::renderDataTable({ DT::datatable(at7987.ld,
                                                           options = list(pageLength = 10)) })
  
output$summary.at7987 <- renderPrint({ summary(at7987.ld)                        })

output$eventplot.at7987 <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_2 == "Event Plot") event.plot(at7987.ld) 
  if (input$PLOT_2 == "Histogram") hist(Response(at7987.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(at7987.ld,"time.units"))})

output$cdfplot.at7987 <- renderPlot({
  par(family = "serif",bg = NA, font = 2)
  plot(at7987.ld, 
       distribution = switch(input$dist_2, 
                             'None'    = NULL,
                             "Weibull" = "Weibull",
                             "Exponential" = "Exponential",
                             "Normal" = 'Normal',
                             "Lognormal" = 'Lognormal',
                             "Smallest Extreme Value" = 'sev',
                             "Largest Extreme Value" = 'lev',
                             "Frechet" = "Frechet" ), 
     conf.level = as.numeric(input$ci_2), band.type = input$bt_2) 
})

output$figures <- codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r',
"
## R code for Figures 6.5, 6.6, and 6.7

## Figure 6.5

at7987.ld <- frame.to.ld(SMRD::at7987,
                         response.column = 1,
                         censor.column = 2,
                         case.weight.column = 3,
                         data.title = 'Alloy t7987 Data',
                         time.units = 'Thousand Cycles')
plot(at7987.ld)

## Figure 6.6

par(family='serif',font=2)
plot(at7987.ld,distribution='Weibull')

## Figure 6.7

par(family='serif',font=2)
plot(at7987.ld,distribution='Lognormal')")

})
}