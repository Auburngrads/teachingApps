server = function(input, output, session) {
  
  output$buyer  <- renderPlot({
    
    N <- input$nsamples
    
#data <- matrix(NA, N, 1)
count = 0
#for(j in 1:N)
#{
  #lognormal distribution with a sample size of N
  set.seed(input$seed)
  weight <- rlnorm(N,log(2000),0.198)
  
  #beta distribution with sample size of N
  
  unit.cost <- rbeta(N,199.5,199.5) * 40
  
  #normal distribution with sample size of N
  
  efficiency <- rnorm(N,1.6,0.2)
  
  #combine to find the total cost
  
  total.cost <- (weight * unit.cost) / sqrt(efficiency)
#  data[j,1] <- total.cost
#}
data.log <- total.cost >= input$threshold
prob <- round(sum(data.log) / N, digits = 4)
#print(prob)
hist(total.cost, 
     xlab = "Total Program Operating Cost (U.S. Dollars)", 
     main = "", 
     breaks = input$breaks, 
     las = 1, 
     col = scales::alpha('blue',.3), 
     cex.axis = 1.2, 
     cex.lab = 1.2,
     mgp = c(3.25,.5, 0), 
        tcl = -0.3, 
        font.lab = 2, 
        font = 2, 
        font.axis = 2, 
        las = 1, 
        tck = 0.015,
     mar = c(4.1, 4.1, .1, 1.1),
     xlim = c(10000,80000))
abline(v=input$threshold, col = rgb(red = prob-0,green = 1-prob,blue = 0), lwd = 3)
mtext(side = 3,
      at = input$threshold,
      text = if(input$threshold<50000) { 
                    substitute(a%<-%b~Pr(cost>=c)~'='~d, 
                               list(a = ' ', b = '', c = paste(c('$',input$threshold), collapse = ''), d = prob)) 
        } else {
                    substitute(Pr(cost>=c)~'='~d~a%->%b, 
                               list(a = '', b = '', c = paste(c('$',input$threshold), collapse = ''), d = prob)) },
      font = 2,
      adj = if(input$threshold<50000) {0} else {1},
      padj = .75,
      cex = 2,
      line = 0,
      col = rgb(red = prob-0,green = 1-prob,blue = 0) )
})
}