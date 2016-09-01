teachingApps::getPackage('scales')

shinyApp(options = list(height = '700px', width = '100%'),
         
ui = navbarPage(theme = shinythemes::shinytheme('flatly'),
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = T),
tabPanel(h4('Normal-Normal'),
   sidebarLayout(
   sidebarPanel(width = 3,
      sliderInput('norm1.1', 
                  label = h2(HTML('Mean - &mu;<sub>1</sub>')), 
                  min = 4,
                  max = 30,
                  step = 1,
                  value = 12),
      sliderInput('norm1.2', 
                  label = h2(HTML('Std Dev - &sigma;<sub>1</sub>')), 
                  min = 1,
                  max = 10,
                  step = .5,
                  value = 4 ),
      sliderInput('norm2.1', 
                  label = h2(HTML('<red>Mean - &#x3BC;<sub>2</sub></red>')), 
                  min = 3,
                  max = 30,
                  step = 1,
                  value = 20),
      sliderInput('norm2.2', 
                  label = h2(HTML('<red>Std Dev - &sigma;<sub>2</sub></red>')), 
                  min = 1,
                  max = 10,
                  step = .5,
                  value = 5 )),
                          
                mainPanel(plotOutput('nor.nor', height = '625px'), width = 9))),
    
tabPanel(h4('Weibull-Weibull'),
   sidebarLayout(
   sidebarPanel(width = 3,
      sliderInput('weib1.1', 
                  label = h2(HTML('Shape - &beta;<sub>1</sub>')), 
                  min = 0.5,
                  max = 6,
                  step = .5,
                  value = 1),
      sliderInput('weib1.2', 
                  label = h2(HTML('Scale - &eta;<sub>1</sub>')), 
                  min = 5,
                  max = 40,
                  step = 1,
                  value = 12 ),
      sliderInput('weib2.1', 
                  label = h2(HTML('<red>Shape - &beta;<sub>2</sub></red>')), 
                  min = 0.5,
                  max = 6,
                  step = 0.5,
                  value = 0.5),
      sliderInput('weib2.2', 
                  label = h2(HTML('<red>Scale - &eta;<sub>2</sub></red>')), 
                  min = 5,
                  max = 40,
                  step = 1,
                  value = 25 )),
               
      mainPanel(plotOutput('weib.weib', height = '625px'), width = 9))),
         
fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApp('crossing_distributions'))})
           
output$nor.nor <- renderPlot({
  
 param1 <- c(input$norm1.1,input$norm1.2)
 param2 <- c(input$norm2.1,input$norm2.2)
 probs <- seq(.00001,.99999, length = 500)
 x.span1 <- qnorm(probs, param1[1], param1[2])
 x.span2 <- qnorm(probs, param2[1], param2[2])
 x.range <- seq(min(x.span1, x.span2),max(x.span1, x.span2), length = 500)
 y.span1 <- dnorm(x.range, param1[1], param1[2])
 y.span2 <- dnorm(x.range, param2[1], param2[2])
 plot(x = x.range,
      y = y.span1, 
      col = 1, type = 'l', lwd = 3, yaxs = 'i',
      xlim = c(min(x.span1, x.span2),max(x.span1, x.span2)),
      ylim = c(min(y.span1, y.span2),max(y.span1, y.span2)*1.04),
      las = 1, xlab = 'Time (t)', ylab = 'f(t)')
 par(new = TRUE)
 plot(x = x.range,
      y = y.span2, 
      col = 2, type = 'l', lwd = 3, yaxs = 'i',
      xlim = c(min(x.span1, x.span2),max(x.span1, x.span2)),
      ylim = c(min(y.span1, y.span2),max(y.span1, y.span2)*1.04),
      las = 1, xlab = '', ylab = '',
      axes = FALSE)
             
dats <- data.frame(x.range, 
                  (log(y.span1)*as.numeric(y.span1>.001))/(log(y.span2)*as.numeric(y.span2>.001)))
             
pts <- which(rank(abs(1-(dats[,2])))==1)

if (min(x.span2) < min(x.span1)) {
  
  pts <- which(rank(round(abs(1-(dats[,2])), digits = 4))==2)
  
}

if(min(rank(round(abs(1-(dats[,2])), digits = 4))) <= 2) {
  
polygon(x = x.range,
        y = c(y.span2[1:pts],y.span1[(pts+1):length(y.span1)]), 
        col = alpha('purple', .4))
}
})
output$weib.weib <- renderPlot({
  w.param1 <- c(input$weib1.1,input$weib1.2)
  w.param2 <- c(input$weib2.1,input$weib2.2)
  probs <- seq(.00001,.99999, length = 500)
  wx.span1 <- qweibull(probs, w.param1[1], w.param1[2])
  wx.span2 <- qweibull(probs, w.param2[1], w.param2[2])
  wx.range <- seq(min(wx.span1, wx.span2),max(wx.span1, wx.span2), length = 500)
  wy.span1 <- dweibull(wx.range, w.param1[1], w.param1[2])
  wy.span2 <- dweibull(wx.range, w.param2[1], w.param2[2])
  plot(x = wx.range,
       y = wy.span1, 
       col = 1, type = 'l', lwd = 3, yaxs = 'i',
       xlim = c(min(wx.span1, wx.span2),max(wx.span1, wx.span2)),
       ylim = c(min(wy.span1, wy.span2),max(wy.span1, wy.span2)*1.04),
       las = 1, xlab = 'Time (t)', ylab = 'f(t)')
  par(new = TRUE)
  plot(x = wx.range,
       x = wy.span2, 
       col = 2, type = 'l', lwd = 3, yaxs = 'i',
       xlim = c(min(wx.span1, wx.span2),max(wx.span1, wx.span2)),
       ylim = c(min(wy.span1, wy.span2),max(wy.span1, wy.span2)*1.04),
       las = 1, xlab = '', ylab = '',
       axes = FALSE)
  
  wdats <- data.frame(wx.range, 
                     (log(wy.span1)*as.numeric(wy.span1>.001))/
                       (log(wy.span2)*as.numeric(wy.span2>.001)))
  
  pts <- which(rank(abs(1-(wdats[,2])))==1)
  
  if (min(wx.span2) < min(wx.span1)) {
    
    pts <- which(rank(round(abs(1-(wdats[,2])), digits = 4))==2)
    
  }
  
  if(min(rank(round(abs(1-(wdats[,2])), digits = 4))) <= 2) {
    
    polygon(x = wx.range,
            y = c(wy.span2[1:pts],wy.span1[(pts+1):length(wy.span1)]), 
            col = alpha('purple', .4))}
})
})
}