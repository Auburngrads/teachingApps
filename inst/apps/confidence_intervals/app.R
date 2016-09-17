library(pos = -1,  package = 'scales')











shinyApp(options = list(height = '600px'),
ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
               try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
 sidebarLayout(
 sidebarPanel(
  sliderInput(inputId = "n",
              h2('Sample Size (n)'),
              value = 10,
              min = 2,
              max = 50,
              step = 1),
  sliderInput(inputId = "confLevel",
              h2("Confidence Level"),
              value = 80,
              min = 50,
              max = 99,
              step = 1),
  actionButton("takeSample",h4("Sample Now"), width = '100%'),
  hr(),
  actionButton("reset",h4("Start Over"), width = '100%')),
 
 mainPanel(plotOutput('ciplot', height = '600px')))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

shapeGamma <- 2
scaleGamma <- 50
xSkew <- seq(0,shapeGamma*scaleGamma+7.5*sqrt(shapeGamma)*scaleGamma,
             length.out=600)
ySkew <- dgamma(xSkew,shape=shapeGamma,scale=scaleGamma)
popDen <- list(x=xSkew,y=ySkew)
popMean <- shapeGamma*scaleGamma
yMax <- 1.5*max(popDen$y)
  
set.seed(as.numeric(Sys.time()))
  
rv <- reactiveValues(sample = NULL, mean = NULL, lower = NULL, upper = NULL, sims = 0,
                       good = 0)
  
observeEvent(input$takeSample, 
               {
                 # random sample and its mean
                 samp <- rgamma(input$n,shape=shapeGamma,scale=scaleGamma)
                 xbar <-  mean(samp)
                 # make bounds for the confidence interval
                 conf = isolate(input$confLevel/100)
                 t.input = conf + ((1 - conf)/2)
                 tMultiplier = qt(t.input, df = input$n - 1)
                 se = sd(samp)/sqrt(input$n)
                 margin = tMultiplier * se
                 # store in rv
                 rv$sample <- rgamma(input$n,shape=shapeGamma,scale=scaleGamma)
                 rv$mean <- xbar
                 rv$lower <- xbar - margin
                 rv$upper <- xbar + margin
                 goodInterval <- popMean >= rv$lower & popMean <= rv$upper
                 rv$sims <- rv$sims + 1
                 rv$good <- rv$good + goodInterval
})

observeEvent(input$reset, 
               {
          rv$sims <- 0
          rv$good <- 0 
               })
             

output$ciplot <- renderPlot({
par(family = "serif", font = 2, bg = NA)  
    # the underlying population
    plot(popDen$x,popDen$y,type="l",lwd=3,col="red",cex.axis = 1.25, yaxt = "n",
         main="Density Curve of Population",
         xlab="",
         ylab="",
         ylim = c(0,yMax))
    text(c(400,500,600),rep(0.0108,3),c("Simulations","Good","Percent Good"), cex = 1.4)
    text(c(400,500,600), rep(0.0100,3),c(rv$sims, rv$good, round(rv$good/rv$sims, digits = 4)), cex = 1.4)
    box(lwd = 2.5)
    axis(side = 2, las = 1, cex.axis = 1.25, tck = 0.025, hadj = 0.65)
    mtext(side = 2, "density f(t)", line = 3, cex.lab = 1.25)
    abline(v=popMean,lwd=2)
    # sample and interval
    if (input$takeSample) {
      # density plot for the sample
      sampDen <- density(rv$sample, from = 0)
      xdens <- sampDen$x
      ydens <- sampDen$y
      firstx <- xdens[1]
      lastx <- xdens[length(xdens)]
      polygon(x = c(firstx,xdens,lastx), y = c(0,ydens,0), col = alpha("lightblue",0.5))
      # now the interval
      intLevel <- 0.95*yMax
      segments(x0 = rv$lower, y0 = intLevel, x1 = rv$upper, y1 = intLevel, 
               col = "green", lwd = 3)
      text(x=rv$lower,y=intLevel,labels="(")
      text(x=rv$upper,y=intLevel,labels=")")
      points(rv$mean, intLevel, col = "blue", pch = 20,cex=2)
      rug(rv$sample)
    }
})
})
