server = function(input, output, session) {

  output$output1 <- renderPlot({

par(las = 1, font = 2, cex = 1.1, cex.axis = 1.1,cex.lab = 1.1,
    mar = c(5,5,3,1))
    
mean = input$mean
sd   = input$sd  
crit = input$crit
xlim = .00001 
x.low  <- min(crit,qnorm(xlim, mean = mean, sd = sd))
x.high <- max(crit,qnorm(1-xlim, mean = mean, sd = sd))

val <- integrate(function(x) dnorm(x,mean = mean, sd = sd), lower = crit, upper = Inf)$value

curve(dnorm(x, mean = mean, sd = sd),
      lwd = 3, 
      col = 2, 
      xlim = c(x.low,x.high),
      yaxs = 'i',
      ylim = c(0,dnorm(mean, mean = mean, sd = sd)*1.05),
      xlab = 'Degradation Measure (d)',
      ylab = 'Pr(D = d)')
abline(v = crit, lwd = 3, col = 4)
 axis(side = 3,
      tck = -0.005, 
      at = crit, lwd = 3,
      col = 4, labels = F)
mtext(side = 3,
      text = paste(c('Pr(D > ',crit,') = ',round(val, digits = 5)), collapse = ''),
      at = crit,
      line = .5,
      cex = 1.2)
polygon(x = c(crit,seq(crit, x.high, length.out = 500)),
        y = c(0,dnorm(seq(crit, x.high, length.out = 500),
                  mean = mean,
                  sd = sd)),
        col = scales::alpha('red', 0.25),
        lty = 0) 
   
})
}