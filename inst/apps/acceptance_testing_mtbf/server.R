server = function(input, output, session) {
  
output$mtbf <- renderPlotly({

mtbf <- seq(1,500,1)
accept <- ppois(input$fails, input$ttt/mtbf)
datas <- data.frame(mtbf, accept) 

observe({

if(input$thresh>=input$objective) { 

   updateSliderInput(session, "objective", value = input$thresh+5) } 

if(input$objective>=input$contract) { 

   updateSliderInput(session, "contract", value = input$objective+5) }
  
})

p1 <- plot_ly(datas, 
              type = 'scatter',
              mode = 'lines',
              x = mtbf, 
              y = accept, 
              showlegend = F, 
              text = paste(
'Pr(accept) = ', round(accept, digits = 5),'<br>',
'True MTBF = ', mtbf,'<br>',
'Allowed Failures = ', input$fails,'<br>',
'Total Test Time = ', input$ttt),
              hoverinfo = 'text')
p2 <- add_segments(p1,
                   x = input$thresh,
                   y = 0,
                   xend = input$thresh, 
                   yend = ppois(input$fails, input$ttt/input$thresh),
                   showlegend = F,
                   hoverinfo = 'none')
p3 <- add_segments(p2,
                   x = input$objective,
                   y = 0,
                   xend = input$objective, 
                   yend = ppois(input$fails, input$ttt/input$objective),
                   showlegend = F,
                   hoverinfo = 'none')
p4 <- add_segments(p3,
                   x = input$contract,
                   y = 0,
                   xend = input$contract, 
                   yend = ppois(input$fails, input$ttt/input$contract),
                   showlegend = F,
                   hoverinfo = 'none')
p5 <- 
  layout(p4,
         yaxis = list(title = "Probability of Acceptance - Pr(accept)",
                      range = extendrange(c(0,ppois(input$fails,
                                                    input$ttt/input$contract)*1.25)),
                      titlefont = list(size = 16)),
         xaxis = list(title = 'True System Reliability - MTBF',
                      range = extendrange(c(input$thresh,input$contract), f = .5),
                      titlefont = list(size = 16)),
             
             annotations = list(
               list(x = c(input$thresh),
                    y = ppois(input$fails, input$ttt/input$thresh),
                    text = 'Threshold ',
                    showarrow = T,
                    ay = -40,
                    ax = -40,
                    arrowhead = 0,
                    arrowcolor = 'orange'),
               list(x = input$objective,
                    y = ppois(input$fails, input$ttt/input$objective),
                    text = "Objective",
                    showarrow = T,
                    ay = -60,
                    ax = -50,
                    arrowhead = 0,
                    arrowcolor = 'green'),
               list(x = input$contract,
                    y = ppois(input$fails, input$ttt/input$contract),
                    text = "Contract",
                    showarrow = T,
                    ay = -80,
                    ax = -60,
                    arrowhead = 0,
                    arrowcolor = 'red')),
             font = list(size = 16))
})
}