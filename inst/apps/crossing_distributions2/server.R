server = function(input, output, session) {

output$cross <- renderPlot({
param1 <- c(input$normal1.1,input$normal1.2)
param2 <- c(input$normal2.1,input$normal2.2)
pdf1 <- curve(dnorm(x,param1[1], param1[2]), 
              col = 1, lwd = .3, 
              xlim = qnorm(c(.00001,.9999999),param1[1], param1[2])*1.5,
              n = 300, las = 1)
pdf2 <- curve(dnorm(x,param2[1], param2[2]), 
              add = TRUE,
              col = 'darkgreen' , lwd = .3, n = 300)

dats <- data.frame(pdf1$x, 
                   (pdf1$y*as.numeric(pdf1$y>.001))/(pdf2$y*as.numeric(pdf2$y>.001)))

pts <- which.min(abs(1-(dats[,2])))

polygon(x = pdf2$x[1:length(pdf2$x)],
        y = c(pdf2$y[1:pts],pdf1$y[(pts+1):length(pdf1$y)]), 
        col = alpha('red', .6))

polygon(x = pdf1$x[1:length(pdf1$x)],
        y = c(pdf1$y[1:pts],pdf2$y[(pts+1):length(pdf2$y)]), 
        col = alpha('blue', .3))
})
}