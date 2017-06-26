server = function(input, output, session) {
  
  output$prop <- renderPlotly({

props <- seq(0,1,.01)
accept2 <- pbinom(input$fails2, input$sss, props)
datas2 <- data.frame(props, accept2) 

observe({

if(input$thresh2>=input$objective2) { 

   updateSliderInput(session, "objective2", value = input$thresh2+.1) } 

if(input$objective2>=input$contract2) { 

   updateSliderInput(session, "contract2", value = input$objective2+.1) }
  
})

p1 <- plot_ly(datas2,
              type = 'scatter',
              mode = 'lines',
              x = props, 
              y = accept2, 
              showlegend = F,
              text = paste(
'Pr(accept) = ', round(accept2, digits = 5),'<br>',
'True Proportion Failing = ', props,'<br>',
'Allowed Failures = ', input$fails2,'<br>',
'Sample Size = ', input$sss),
              hoverinfo = 'text')
p2 <- add_segments(p1, 
                   x = input$thresh2,
                   y = 0,
                   xend = input$thresh2,
                   yend = pbinom(input$fails2, input$sss,input$thresh2),
                   showlegend = F,
                  hoverinfo = 'none')
p3 <- add_segments(p2, 
                   x = input$objective2,
                   y = 0,
                   xend = input$objective2,
                   yend = pbinom(input$fails2, input$sss, input$objective2),
                   showlegend = F,
                   hoverinfo = 'none')
p4 <- add_segments(p3, 
                   x = input$contract2,
                   xend = input$contract2,
                   y = 0,
                   yend = pbinom(input$fails2, input$sss, input$contract2),
                   showlegend = F,
                   hoverinfo = 'none')
p5 <- layout(p4, 
             yaxis = list(title = "Probability of Acceptance"), 
             xaxis = list(title = 'Proportion Conforming'),
             
             annotations = list(
               list(x = c(input$thresh2),
                    y = pbinom(input$fails2, input$sss, input$thresh2),
                    text = 'Threshold ',
                    showarrow = T,
                    ay = -40,
                    ax =  40),
               list(x = input$objective2,
                    y = pbinom(input$fails2, input$sss, input$objective2),
                    text = "Objective",
                    showarrow = T,
                    ay = -60,
                    ax =  50),
               list(x = input$contract2,
                    y = pbinom(input$fails2, input$sss, input$contract2),
                    text = "Contract",
                    showarrow = T,
                    ay = -80,
                    ax =  60)),
             font = list(size = 16))
})
}