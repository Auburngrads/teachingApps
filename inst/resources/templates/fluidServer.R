server = function(input, output, session) {

  output$output1 <- renderPlot({
    
   dist <- switch(input$input1, 
           
      'Weibull' = {
             
      w.shape = 2.15  
      w.scale = 15 
      w.mean = w.scale*gamma(1+1/w.shape)  
      w.var<-w.scale^2*(gamma(1+2/w.shape)-gamma(1+1/w.shape)^2)
      dist <- replicate(300,
                        sqrt(input$input3)*(mean(rweibull(input$input3,
                                                     shape=w.shape, 
                                                     scale=w.scale))-w.mean)/sqrt(w.var))},
          
      'Exponential' = {
       e.rate =.5
       e.mean = 1/e.rate 
       e.var  = 1/e.rate^2
       dist <- replicate(300,
                         sqrt(input$input3)*(mean(rexp(input$input3, e.rate))-e.mean)/sqrt(e.var))},
           
      'Gamma' = {
       g.shape = 2  
       g.scale = 1 
       g.mean = g.scale*g.shape ; g.var<-(g.shape-1)*g.scale
       dist <- replicate(300,
                         sqrt(input$input3)*(mean(rgamma(input$input3,
                                                    shape=g.shape, 
                                                    scale=g.scale))-g.mean)/sqrt(g.var))},
      
      'Lognormal' = {
       l.shape = .6 
       l.scale = 10
       l.mean = exp(l.scale+l.shape^2/2) 
       l.var = (exp(l.shape^2)-1)*exp(2*l.scale+l.shape^2)
       dist <- replicate(300,
                         sqrt(input$input3)*(mean(rlnorm(input$input3, 
                                                    meanlog=l.scale, 
                                                    sdlog=l.shape))-l.mean)/sqrt(l.var))},  

      'Normal' = {
       dist <- replicate(300,sqrt(input$input3)*mean(rnorm(input$input3, mean=0, sd=1)))},
      
      'Uniform' = {
       dist <- replicate(300,sqrt(input$input3)*(mean(runif(input$input3, 0,1))-.5)/sqrt(1/12))})
   
  hist(dist, 
       probability = TRUE, 
       col = "bisque", 
       breaks = input$input2,
       xlab = "Mean", 
       main = "Distribution of the Mean",
       xlim = range(-4,4))
  
lines(density(dist),
      col = "blue",
      lwd = 2.5)
})
}