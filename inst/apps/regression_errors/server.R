server = function(input, output, session) {
  
  ### Saving data:
Rawdata <- reactive({
    input$refresh 
    input$refresh2 
     
    slope  <- input$slope
    SD     <- input$SD
    sample <- input$sample
  
    x <- round(1:sample + rnorm(n = sample, mean = 1, sd = 2), 
               digits = 2)
    y <- round(slope * (x) + rnorm(n = sample, mean = 3, sd = SD ), 
               digits = 2)
  
    mod     <- lm(y ~ x, data.frame(y,x))
    ypred   <- predict(mod)
    Rawdata <- data.frame(y, x, ypred)
})

SSdata <- reactive({
    dat <- Rawdata()
    Y   <- mean(dat$y)
    mod <- lm(y ~ x, dat)
    ypred <- predict(mod)
    dat$ypred <- ypred
    SST <- sum((dat$y - Y)^2)
    SSE <- round(sum((dat$y - ypred)^2), digits = 5)
    SSA <- SST - SSE

    SSQ <- data.frame(SS = c("Total","Regression","Error"),
                      value = as.numeric(c(SST, SSA, SSE)/SST)*100)
    SSQ$SS <- factor(SSQ$SS, 
                     as.character(SSQ$SS))
    SSdata <- data.frame(SS = factor(SSQ$SS, as.character(SSQ$SS)),
                      value = as.numeric(c(SST, SSA, SSE)))
})

output$total <- renderPlot({
par(lwd = 2.5, las = 1, mar = c(4.25,4.25,3,1))
plot(x = Rawdata()$x,
     y = Rawdata()$y,
     pch = 16,
     cex = 1.5,
     xlab = 'Observation Number', ylab = 'Observation',
     cex.axis = 1.5, cex.lab = 1.5)
abline(h = mean(Rawdata()[,1]), lwd = 1)
abline(lm(y~x, data = Rawdata())$coeff)
segments(x0 = Rawdata()$x,
         y0 = Rawdata()$y,
         x1 = Rawdata()[,2],
         y1 = mean(Rawdata()[,1]),
         col = 'green')
segments(x0 = Rawdata()$x,
         y0 = Rawdata()$y,
         x1 = Rawdata()[,2],
         y1 = Rawdata()[,3],
         col = 'red')
points(x = Rawdata()$x,y = Rawdata()$y,pch = 16,cex = 2.0)

legend(bty = 'n','topleft',lwd = 5, xpd = T,inset = c(0,-.1),
       seg.len = 5, col = 1, cex = 1.75,
       legend = parse(text = paste('SS[Total]',
                                   '==',
                                   sprintf("%.2f",SSdata()$value[1]))))
legend(bty = 'n','top',lwd = 5, xpd = T,inset = c(0,-.1),
       seg.len = SSdata()$value[2]/SSdata()$value[1]*5,
       col = 'green', cex = 1.75,
       legend = parse(text = paste('SS[Model]',
                                   '==',
                                   sprintf("%.2f",SSdata()$value[2]))))
legend(bty = 'n','topright',lwd = 5, xpd = T,inset = c(0,-.1),
       seg.len = SSdata()$value[3]/SSdata()$value[1]*5,
       col = 'red', cex = 1.75,
       legend = parse(text = paste('SS[Error]',
                                   '==',
                                   sprintf("%.2f",SSdata()$value[3]))))
})
output$regress <- renderPlot({
par(lwd = 2.5, las = 1, mar = c(4.25,4.25,3,1))
plot(x = Rawdata()$x,
     y = Rawdata()$y,
     pch = 16,
     cex = 1.5,
     xlab = 'Observation Number', ylab = 'Observation',
     cex.axis = 1.5, cex.lab = 1.5)
abline(h = mean(Rawdata()[,1]), lwd = 1)
abline(lm(y~x, data = Rawdata())$coeff)
segments(x0 = Rawdata()$x,
         y0 = Rawdata()$y,
         x1 = Rawdata()[,2],
         y1 = Rawdata()[,3],
         col = 'green')
points(x = Rawdata()$x,y = Rawdata()$y,pch = 16,cex = 2.0)
})
output$error <- renderPlot({
par(lwd = 2.5, las = 1, mar = c(4.25,4.25,3,1))
plot(x = Rawdata()$x,
     y = Rawdata()$y,
     pch = 16,
     cex = 1.5,
     xlab = 'Observation Number', ylab = 'Observation',
     cex.axis = 1.5, cex.lab = 1.5)
abline(h = mean(Rawdata()[,1]), lwd = 1)
segments(x0 = Rawdata()$x,
         y0 = mean(Rawdata()[,1]),
         x1 = Rawdata()[,2],
         y1 = Rawdata()$y,
         col = 'red')
points(x = Rawdata()$x,y = Rawdata()$y,pch = 16,cex = 2.0)
})
}
