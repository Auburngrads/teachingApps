server = function(input, output, session) {

mle <- reactiveValues(dats = NULL,
                      params = NULL,
                      sims = 0,
                      dat1 = NULL,
                      dat2 = NULL,
                      dat3 = NULL)

observeEvent(input$clear, {

  params <- switch(input$correct,
                   'Green' = c(2.4,40),
                   'Blue' = c(2.5,50),
                   'Red' = c(2,50))

  mle$sims <- 0 ; mle$dats <- NULL ; mle$dat1 <- NULL ; mle$dat2 <- NULL ; mle$dat3 <- NULL

   mle$dats[mle$sims] <- NULL #rweibull(1,params[1], params[2])
   mle$dat1[mle$sims] <- NULL #dweibull(mle$dats[mle$sims], 2.5,50)
   mle$dat2[mle$sims] <- NULL #dweibull(mle$dats[mle$sims], 2.5,40)
   mle$dat3[mle$sims] <- NULL #dweibull(mle$dats[mle$sims], 2.0,50)
})

observeEvent(input$mlesample10, {

  params <- switch(input$correct,
                   'Green' = c(2.4,40),
                   'Blue' = c(2.5,50),
                   'Red' = c(2,50))

  mle$sims <- mle$sims + 10

  mle$dats[(mle$sims-9):mle$sims] <- rweibull(10,params[1], params[2])
  mle$dat1[(mle$sims-9):mle$sims] <- dweibull(mle$dats[(mle$sims-9):mle$sims], 2.5,50)
  mle$dat2[(mle$sims-9):mle$sims] <- dweibull(mle$dats[(mle$sims-9):mle$sims], 2.5,40)
  mle$dat3[(mle$sims-9):mle$sims] <- dweibull(mle$dats[(mle$sims-9):mle$sims], 2.0,50)
})

observeEvent(input$mlesample, {
  params <- switch(input$correct,
                   'Green' = c(2.4,40),
                   'Blue' = c(2.5,50),
                   'Red' = c(2,50))

  mle$sims <- mle$sims + 1

  mle$dats[mle$sims] <- rweibull(1,params[1], params[2])
  mle$dat1[mle$sims] <- dweibull(mle$dats[mle$sims], 2.5,50)
  mle$dat2[mle$sims] <- dweibull(mle$dats[mle$sims], 2.5,40)
  mle$dat3[mle$sims] <- dweibull(mle$dats[mle$sims], 2.0,50)

  })

output$plotmle <- renderPlot({

par(family = 'serif', font = 1, mar = c(4.5,6,1,1))

  polygon(curve(dweibull(x, 2.5,50),
                xlim = c(0,130),
                ylim = c(0,.03),
                ylab = '',
                xlab = '',
                col = alpha('blue', 1),
                yaxt = 'n',
                xaxt = 'n',
                yaxs = 'i',
                lwd = 2,
                xaxs = 'i'),
          col = alpha('blue', 0.25),
          border = NA)

  polygon(curve(dweibull(x, 2.5,40),
                xlim = c(0,130),
                col = alpha('darkgreen', 1),
                add = TRUE,
                lwd = 2),
          col = alpha('green', 0.25),
          border = NA)

  polygon(curve(dweibull(x, 2.0,50),
                xlim = c(0,130),
                col = alpha('red', 1),
                add = TRUE, lwd = 2),
          col = alpha('pink', 0.25),
          border = NA)
  box(lwd = 1.5)

mtext(side = 3, 'f(t)', line = -2, at = -1, cex = 2, adj = 1, font = 2)

text(x = 110,
     y = .005,
     labels = paste('total samples =', mle$sims, sep = " "),
     cex = 2,
     font = 2)
text(x = rep(60,3),
     y = c(0.025,0.0225, 0.02),
     labels = c('Blue', 'Green', 'Red'),
     col = c('blue', 'darkgreen', 'red'),
     cex = 2,
     adj = 0,
     font = 2)
text(x = rep(70,3),
     y = c(0.025,0.0225, 0.02)-.0001,
     rep('=',3),
     col = c('blue', 'darkgreen', 'red'),
     cex = 2,
     adj = 0,
     font = 2)
text(x = 60,
     y = 0.028,
     labels = expression(bold(prod(f(t[i]~symbol('|')~theta),i==1,n)
                     ==sum(log~bgroup('[',f(t[i]~symbol('|')~theta),']'),
                           i==1,n)%->%Log-likelihood)),
     adj = 0,
     cex = 1.8)

  if(input$mlesample) {
    if(!mle$sims==0) {

dat4 <- max(mle$dat1[mle$sims], mle$dat2[mle$sims], mle$dat3[mle$sims])

segments(x0 <- c(0,0,0,mle$dats[mle$sims]),
         y0 <- c(mle$dat1[mle$sims],mle$dat2[mle$sims],mle$dat3[mle$sims],0),
         x1 <- rep(mle$dats[mle$sims],4),
         y1 <- c(mle$dat1[mle$sims],mle$dat2[mle$sims],mle$dat3[mle$sims], dat4),
         col = c('blue', 'darkgreen', 'red', 'black'),
         lwd = c(2,2,2,1),
         lty = c(1,1,1,3))

points(mle$dats[1:mle$sims],mle$dat1[1:mle$sims], pch = 16, cex = 2, col = alpha('blue', 1))
points(mle$dats[1:mle$sims],mle$dat2[1:mle$sims], pch = 16, cex = 2, col = alpha('darkgreen', 1))
points(mle$dats[1:mle$sims],mle$dat3[1:mle$sims], pch = 16, cex = 2, col = alpha('red', 1))

text(x = rep(74,3), y = c(0.025,0.0225, 0.02),
     c(round(sum(log(mle$dat1)), digits = 4),
       round(sum(log(mle$dat2)), digits = 4),
       round(sum(log(mle$dat3)), digits = 4)),
     col = c('blue', 'darkgreen', 'red'),
     cex = 2, adj = 0)

dat5 <- max(c(round(sum(log(mle$dat1)), digits = 4),
              round(sum(log(mle$dat2)), digits = 4),
              round(sum(log(mle$dat3)), digits = 4)))

if (dat5==round(sum(log(mle$dat1)), digits = 4)) points(57.5,.0250,pch=16, col='blue', cex=2)
if (dat5==round(sum(log(mle$dat2)), digits = 4)) points(57.5,.0225,pch=16, col='darkgreen', cex=2)
if (dat5==round(sum(log(mle$dat3)), digits = 4)) points(57.5,.0200,pch=16, col='red', cex=2)

axis(side = 1,
     labels = paste('t = ', round(mle$dats[mle$sims], digits = 2), sep = ""),
     at = mle$dats[mle$sims],
     padj = -.75, cex.axis = 2, line = 1.5, tck = 0)
axis(side = 2,
     labels = round(mle$dat1[mle$sims], digits = 4),
     line = -.9, at = mle$dat1[mle$sims],
     las = 1, cex.axis = 2, col.axis = 'blue', tck = 0)
axis(side = 2,
     labels = round(mle$dat2[mle$sims], digits = 4),
     line = -.9, at = mle$dat2[mle$sims],
     las = 1, cex.axis = 2, col.axis = 'darkgreen', tck = 0)
axis(side = 2,
     labels = round(mle$dat3[mle$sims], digits = 4),
     line = -.9,
     at = mle$dat3[mle$sims], las = 1, cex.axis = 2, col.axis = 'red', tck = 0)
    }
  }

  if(input$mlesample10) {
    if(!mle$sims==0) {
points(mle$dats[1:mle$sims],mle$dat1[1:mle$sims], pch = 16, cex = 2, col = alpha('blue', 1))
points(mle$dats[1:mle$sims],mle$dat2[1:mle$sims], pch = 16, cex = 2, col = alpha('darkgreen', 1))
points(mle$dats[1:mle$sims],mle$dat3[1:mle$sims], pch = 16, cex = 2, col = alpha('red', 1))

text(x = rep(74,3), y = c(0.025,0.0225, 0.02),
     c(round(sum(log(mle$dat1)), digits = 4),
       round(sum(log(mle$dat2)), digits = 4),
       round(sum(log(mle$dat3)), digits = 4)),
     col = c('blue', 'darkgreen', 'red'), cex = 2, adj = 0)
axis(side = 1, labels = FALSE, at = mle$dats[mle$sims], padj = -.75, cex.axis = 2, tck = 0)
axis(side = 2, labels = FALSE, tck = 0, las = 1, cex.axis = 2)
    }
  }
})
}
