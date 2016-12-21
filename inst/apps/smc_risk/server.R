server = function(input, output, session) {

# beta = input$weib1.1
# eta = input$weib1.2
# mu = input$tri2.1
# sigma = input$tri2.2
#   
#   one <- integrate(function(x) exp(-(x/eta)^beta)*(4/sigma^2)*( x-mu+sigma/2), lower = mu-sigma/2, upper = mu)$value
#   two <- integrate(function(x) exp(-(x/eta)^beta)*(4/sigma^2)*(-x+mu+sigma/2), lower = mu, upper = mu+sigma/2)$value
  
 param1  <- reactive({ c(input$weib1.1,input$weib1.2) })
 param2  <- reactive({ c(input$tri2.1,input$tri2.2)   })
 probs   <- signif(seq(.001,.999, length = 500), digits = 4)
 x.span1 <- reactive({ qweibull(probs, shape = param1()[1], scale = param1()[2]) })
 x.span2 <- reactive({ qtriangle(probs, 
                      a = param2()[1]-param2()[2]/2,
                      b = param2()[1]+param2()[2]/2,
                      c = param2()[1]) })
 x.range <- reactive({ signif(seq(min(x.span1(), x.span2()),max(x.span1(), x.span2()), length = 500), digits = 4) })
 y.span1 <- reactive({ 1-pweibull(x.range(), shape = param1()[1], scale = param1()[2]) })
 y.span2 <- reactive({ dtriangle(x.range(), 
                      a = param2()[1]-param2()[2]/2,
                      b = param2()[1]+param2()[2]/2,
                      c = param2()[1]) })
 
  data.t <- reactive({ data.frame(Time = x.range(), WEIB = y.span1(), TRIA = y.span2()) })

output$weibtri <- renderMetricsgraphics({
  
  mjs_plot(data.t(), x = Time, y = WEIB, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(y_label = 'S(t)')%>%
    mjs_add_line(TRIA) %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
  
 # plot(x = x.range,
 #      y = y.span1, 
 #      col = 1, type = 'l', lwd = 3, yaxs = 'i',
 #      xlim = c(min(x.span1, x.span2),max(x.span1, x.span2)),
 #      ylim = c(min(y.span1, y.span2),max(y.span1, y.span2)*1.04),
 #      las = 1, xlab = 'Time (t)', ylab = 'f(t)')
 # par(new = TRUE)
 # plot(x = x.range,
 #      y = y.span2, 
 #      col = 2, type = 'l', lwd = 3, yaxs = 'i',
 #      xlim = c(min(x.span1, x.span2),max(x.span1, x.span2)),
 #      ylim = c(min(y.span1, y.span2),max(y.span1, y.span2)*1.04),
 #      las = 1, xlab = '', ylab = '',
 #      axes = FALSE)
# text(x = 0.9*max(x.range),
#      y = 0.9*max(y.span1,y.span2),
#      labels = one+two)
#              
# dats <- data.frame(x.range, 
#                   (log(y.span1)*as.numeric(y.span1>.001))/(log(y.span2)*as.numeric(y.span2>.001)))
#              
# pts <- which(rank(abs(1-(dats[,2])))==1)
# 
# if (min(x.span2) < min(x.span1)) {
#   
#   pts <- which(rank(round(abs(1-(dats[,2])), digits = 4))==2)
#   
# }
# 
# if(min(rank(round(abs(1-(dats[,2])), digits = 4))) <= 2) {
#   
# polygon(x = x.range,
#         y = c(y.span2[1:pts],y.span1[(pts+1):length(y.span1)]), 
#         col = alpha('purple', .4))
# }
  
})
}