complex_ideas <-
function(...) {
  
  library(shiny)
  library(scales) # for transparency in density-plot fill
  library(metricsgraphics)

############################################################
## Set up the gamma-distributed population
###########################################################


############################################################
## ui
############################################################
shinyApp(options = list(width = "100%", height = "800px"),
ui = navbarPage(theme = shinythemes::shinytheme("flatly"),
                includeCSS('css/my-shiny.css'),
                
tabPanel(h4("Conf. Intervals"),
sidebarLayout(
  sidebarPanel(width = 3,
  sliderInput(inputId = "n",
              h2("Sample Size"), 
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
  hr(),
  actionButton("takeSample",h4("Generate A Sample"), width = '100%'), hr(),
  actionButton("reset",h4("Clear & Re-Start"), width = '100%')),
  
  mainPanel(plotOutput("plotci", height = "650px"), width = 9))),

tabPanel(h4("CLT"),
sidebarLayout(
  sidebarPanel(width = 3,
  selectInput("distribution", 
              h2("Distribution"),
              choices = c("Weibull", 
                          "Exponential",
                          "Gamma",
                          "Normal",
                          "Lognormal",
                          "Uniform"),
              selected = "Uniform"),
  
  sliderInput("bins", 
              label = h2("Number of Bins"),
              min = 10, 
              max = 50, 
              value = 10, 
              step = 10),
  
  sliderInput("S", 
              label = h2("Sample Size"),
              min = 3,
              max = 30,
              value = 3,
              step = 3,
              animate=TRUE)),
  
  mainPanel(plotOutput("plotclt", height = "650px"),width = 9))),

tabPanel(h4("Prob Plots"),
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("distro1", 
              label = h2("Distribution 1"),
              choices = c("Exponential",
                          "Normal",
                          "SEV",
                          "Logistic",
                          "LEV"), 
              selected = "SEV"),
  selectInput("axis1", label = h2(HTML("<b>Distribution 1 Axis:</b>")),
              choices = c("True Axis","Transformed Axis"), selected = "True Axis"),
  selectInput("distro2", label = h2(HTML("<b>Distribution 2:</b>")),
              choices = c("Exponential","Normal","SEV","Logistic","LEV"), selected = "SEV"),
  selectInput("axis2", label = h2(HTML("<b>Distribution 2 Axis:</b>")),
              choices = c("True Axis","Transformed Axis"), selected = "Transformed Axis")),

mainPanel(plotOutput("probplot", height = "650px"), width = 9 ))),

tabPanel(h4("Weibull Distro"),
  sidebarLayout(
    sidebarPanel(width = 3,
  selectInput("w", label = h2(HTML("<b>Function:</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "PDF"),
  
  sliderInput("range.w", label = h2(HTML("<b>Range:</b>")),
              min = 0, max = 50, value = c(0,25)),
  sliderInput("scale.w", label = h2(HTML("<b>Scale:</b>")),
              min = 5, max = 30, step = 5, value = 10, animate=TRUE),
  sliderInput("shape.w", label = h2(HTML("<b>Shape:</b>")),
              min = .5, max = 6, step=.5, value = .5 ,animate=TRUE)),
  
  mainPanel(metricsgraphicsOutput("plotweib",height = "650px"),width = 9))),

tabPanel(h4("ML Estimation"), 
sidebarLayout(
  sidebarPanel(width = 3,
    selectInput('correct', h2(HTML('<b>True Distribution</b>')), choices = c('Green', 'Blue', 'Red'), selected = 'Blue'),
    hr(),
    actionButton('mlesample',h4('Generate 1 Sample'), width = '100%'), 
    hr(),
    actionButton('mlesample10',h4('Generate 10 Samples'), width = '100%'),
    
    hr(),
    
    actionButton('clear',h4('Clear All Samples'), width = '100%')),
  
  mainPanel(plotOutput('plotmle', height = '650px'), width = 9)))),

server = function(input, output, session) {

shapeGamma <- 2
scaleGamma <- 50
xSkew <- seq(0,shapeGamma*scaleGamma+7.5*sqrt(shapeGamma)*scaleGamma,
             length.out=600)
ySkew <- dgamma(xSkew,shape=shapeGamma,scale=scaleGamma)
popDen <- list(x=xSkew,y=ySkew)
popMean <- shapeGamma*scaleGamma
yMax <- 1.5*max(popDen$y)
  
## set seed so that users are likely to get different results
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
             

output$plotci <- renderPlot({
par(family = "serif", font = 2, mar = c(4.5,4,1,2))  
    # the underlying population
    plot(popDen$x,popDen$y,type="l",lwd=3,col="red",cex.axis = 1.25, yaxt = "n",
         xlab=expression(bold("t")),
         ylab="",
         ylim = c(0,yMax), cex.lab = 1.5)
    text(c(300,400,500),rep(0.0108,3),c("Simulations","Good","Percent Good"), cex = 2)
    text(c(300,400,500), rep(0.0100,3),c(rv$sims, rv$good, round(rv$good/rv$sims, digits = 4)), cex = 2)
    box(lwd = 2.5)
    axis(side = 2, las = 1, cex.axis = 1.25, tck = 0.025, hadj = 0.65)
    mtext(side = 2, "density f(t)", line = 3, cex.lab = 1.5)
    abline(v=popMean,lwd=2)
    # sample and interval
    if (input$takeSample) {
      # density plot for the sample
      sampDen <- density(rv$sample, from = 0)
      xdens <- sampDen$x
      ydens <- sampDen$y
      firstx <- xdens[1]
      lastx <- xdens[length(xdens)]
      lines(density(rv$sample, from = 0), lwd = 2, col = "blue")
      polygon(x = c(firstx,xdens,lastx), y = c(0,ydens,0), col = alpha("blue",0.25))
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

output$plotclt <- renderPlot({
  set.seed(42)
par(bg=NA, family="serif", mar = c(4,4,1,2))
if(input$distribution=="Weibull"    )  {
  w.shape<-2.15 
  w.scale=15 
  w.mean <- w.scale*gamma(1+1/w.shape) ;  
  w.var<-w.scale^2*(gamma(1+2/w.shape)-gamma(1+1/w.shape)^2)
  dist <- replicate(300,sqrt(input$S)*(mean(rweibull(input$S,shape=w.shape, scale=w.scale))-w.mean)/sqrt(w.var))} else

if(input$distribution=="Exponential")  {
  e.rate<-.5
  e.mean<-1/e.rate
  e.var<-1/e.rate^2
  dist <- replicate(300,sqrt(input$S)*(mean(rexp(input$S, e.rate))-e.mean)/sqrt(e.var))}  else

if(input$distribution=="Gamma"    )    {
  g.shape<-2
  g.scale=1
  g.mean<-g.scale*g.shape
  g.var<-(g.shape-1)*g.scale
  dist <- replicate(300,sqrt(input$S)*(mean(rgamma(input$S,shape=g.shape, scale=g.scale))-g.mean)/sqrt(g.var))}   else

if(input$distribution=="Lognormal")	   {
  l.shape<-.6
  l.scale=10 
  l.mean<-exp(l.scale+l.shape^2/2) 
  l.var<-(exp(l.shape^2)-1)*exp(2*l.scale+l.shape^2)
  dist <- replicate(300,sqrt(input$S)*(mean(rlnorm(input$S, mean=l.scale, sd=l.shape))-l.mean)/sqrt(l.var))}    else

if(input$distribution=="Normal")       
  {dist <- replicate(300,sqrt(input$S)*mean(rnorm(input$S, mean=0, sd=1)))} else   
    
  dist <- replicate(300,sqrt(input$S)*(mean(runif(input$S, 0,1))-.5)/sqrt(1/12))

hist(dist, probability = TRUE, 
     col="bisque", 
     breaks=input$bins,
     xlab = "Mean",
     main="",
     xlim=range(-4,4),
     cex.lab = 1.5,
     yaxs = 'i',
     las = 1)
par(new=TRUE)
plot(density(dist),
     lwd=2,
     col = "blue",
     main="",
     xlab="",
     ylab="",yaxs = 'i', 
     axes=FALSE,
     xlim=range(-4,4))
polygon(density(dist, lwd = .1), col = alpha("lightblue",0.25))
})

output$probplot <- renderPlot({

CDF<-seq(.01,.99,.03)
par(mfrow = c(1,2),family="serif",font=1,bg=NA, mar = c(3.5,4.1,1.5,2.1))

switch(input$distro1,

"SEV" = { 

  WEIB<-(log(log(1/(1-CDF))))
  plot(NA,xlim=range(1,100),ylim=range(WEIB),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=WEIB, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression(Phi[SEV](t[p])),line = 2,cex = 1.3)
    switch(input$axis1, 
      "True Axis" = {
        axis( side=2, labels=NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
        mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),            
              round(qsev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },

      "Transformed Axis" = {
        axis( side=2, labels=NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
        mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Normal" = {

  LOGN<-(qnorm(CDF))
  plot(NA,xlim=range(1,100),ylim=range(LOGN),ylab="",xlab="",axes=FALSE)
  abline(h=LOGN, lty=2,col="steelblue")
  box(lwd=1.25)
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[NOR](t[p])),line = 2,cex = 1.3)
    switch(input$axis1, 
    "True Axis" = {
      axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
      mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qnorm(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },

    "Transformed Axis" = {
      axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
      mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Logistic" = {

  LLOG<-qlogis(CDF)
  plot(NA,xlim=range(1,100),ylim=range(LLOG),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=LLOG, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[logis](t[p])),line = 2,cex = 1.3)

  switch(input$axis1, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlogis(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },

         "Transformed Axis" = {
           axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
  
}, "LEV" = {

  LLEV<-qlev(CDF)
  plot(NA,xlim=range(1,100),ylim=range(LLEV),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=LLEV, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[LEV](t[p])),line = 2,cex = 1.3)

  switch(input$axis1, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)  },

         "Transformed Axis" = {
           axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
  
}, "Exponential" = {

  EXP<-qexp(CDF)
  plot(NA,xlim=range(1,100),ylim=range(EXP),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=EXP, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( F[EXP](t[p])),line = 2,cex = 1.3)

  switch(input$axis1, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qexp(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },

         "Transformed Axis" = {
           axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
})

switch(input$distro2,
  
"SEV" = { 

  WEIB<-(log(log(1/(1-CDF))))
  plot(NA,xlim=range(1,100),ylim=range(WEIB),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=WEIB, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[SEV](t[p])),line = 2,cex = 1.3)

  switch(input$axis2, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qsev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)  },

         "Transformed Axis" = {
           axis( side=2, labels=NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
  
}, "Normal" = {

  LOGN<-(qnorm(CDF))
  plot(NA,xlim=range(1,100),ylim=range(LOGN),ylab="",xlab="",axes=FALSE)
  abline(h=LOGN, lty=2,col="steelblue")
  box(lwd=1.25)
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[NOR](t[p])),line = 2,cex = 1.3)

  switch(input$axis2, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qnorm(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },

         "Transformed Axis" = {
           axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
  
}, "Logistic" = {

  LLOG<-qlogis(CDF)
  plot(NA,xlim=range(1,100),ylim=range(LLOG),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=LLOG, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[logis](t[p])),line = 2,cex = 1.3)

  switch(input$axis2, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlogis(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },

         "Transformed Axis" = { 
           axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
  
}, "LEV" = {

  LLEV<-qlev(CDF)
  plot(NA,xlim=range(1,100),ylim=range(LLEV),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=LLEV, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( Phi[LEV](t[p])),line = 2,cex = 1.3)

  switch(input$axis2, 
         "True Axis" = {
           axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)  },

         "Transformed Axis" = { 
           axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
  
}, "Exponential" = {

  EXP<-qexp(CDF)
  plot(NA,xlim=range(1,100),ylim=range(EXP),ylab="",xlab="",axes=FALSE)
  box(lwd=1.25)
  abline(h=EXP, lty=2,col="steelblue")
  axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
  mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
  mtext(side = 2, expression( F[EXP](t[p])),line = 2,cex = 1.3)

  switch(input$axis2, 
         "True Axis" = {
           axis( side=2, 
                 labels=NA, 
                 at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, 
                 at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),               
                 round(qexp(c(.01,.05,.1,.2,.5,.9,.97)),
                       digits = 1),line=.75)     },

         "Transformed Axis" = {
           axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
           mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
})
par(mfrow = c(1,1))
})

output$plotweib <- renderMetricsgraphics({

weibhaz <-function(x,sc, sh) {sh/sc*(x/sc)^(sh-1)}
Time<-signif(seq(min(input$range.w), max(input$range.w), length = 500),digits = 4)

CDF <- pweibull(Time,sc=input$scale.w,sh=input$shape.w)
PDF <- dweibull(Time,sc=input$scale.w,sh=input$shape.w)
REL <- 1-CDF
haz <- weibhaz(Time, sc=input$scale.w,sh=input$shape.w)
HAZ <- -1*log(1-pweibull(Time,sc=input$scale.w,sh=input$shape.w))
weib.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)

PLOT <- switch (input$w, 
                'CDF' = {
  mjs_plot(weib.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)')},
  
                'PDF' = {
  mjs_plot(weib.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(weib.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(weib.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(weib.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT

})

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
               mle$sims <- 1
               mle$dats <- NULL; mle$dat1 <- NULL; mle$dat2 <- NULL; mle$dat3 <- NULL
               mle$dats[mle$sims] <- rweibull(1,params[1], params[2])
               mle$dat1[mle$sims] <- dweibull(mle$dats[mle$sims], 2.5,50)
               mle$dat2[mle$sims] <- dweibull(mle$dats[mle$sims], 2.5,40)
               mle$dat3[mle$sims] <- dweibull(mle$dats[mle$sims], 2.0,50)
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
  
par(family = 'serif', font = 1, mar = c(2,3,1,1), cex = 2, font = 2)
  xlim = c(0,130)

polygon(curve(dweibull(x, 2.5,50), 
              xlim = xlim, 
              ylab = '', xlab = '', 
              col = alpha('blue', 1),
              yaxt = 'n', xaxt = 'n', 
              ylim = c(0,.03), 
              yaxs = 'i', xaxs = 'i',
              lwd = 2), 
        col = alpha('blue', 0.25), 
        border = NA)

polygon(curve(dweibull(x, 2.5,40),
              col = alpha('darkgreen', 1),
              xlim = xlim,
              add = TRUE, 
              lwd = 2), 
        col = alpha('green', 0.25), 
        border = NA)
  
polygon(curve(dweibull(x, 2.0,50), 
              col = alpha('red', 1),
              xlim = xlim,
              add = TRUE, 
              lwd = 2), 
        col = alpha('pink', 0.25), 
        border = NA)
box(lwd = 1.5)
mtext(side = 3, 'f(t)', line = -2, at = -1, adj = 1, font = 2, cex = 2)
  
text(x = rep(c(55, 69), each = 3), 
     y = rep(c(0.025,0.0225, 0.02), 2), 
     rep(c('Blue', 'Green', 'Red', rep('=',3)), 2), 
     col = rep(c('blue', 'darkgreen', 'red'), 2),
     adj = 0)

text(x = c(95,55), 
     y = c(.005,0.028), 
     c(paste('total samples =', mle$sims, sep = " "), 
       expression(bold(prod(f(t[i]~symbol('|')~theta),i==1,n)==sum(log~bgroup('[',f(t[i]~symbol('|')~theta),']'), i==1,n)%->%Log-likelihood))), 
     adj = 0,
     font = 2)

  if(input$mlesample | input$mlesample10) { 

dat4 <- max(mle$dat1[mle$sims], mle$dat2[mle$sims], mle$dat3[mle$sims])

segments(x0 = c(0,0,0,mle$dats[mle$sims]), 
         y0 = c(mle$dat1[mle$sims],
               mle$dat2[mle$sims],
               mle$dat3[mle$sims],0),
         x1 = rep(mle$dats[mle$sims],4),
         y1 = c(mle$dat1[mle$sims],mle$dat2[mle$sims],mle$dat3[mle$sims], dat4), 
         col = c('blue', 'darkgreen', 'red', 'black'), 
         lwd = c(2,2,2,1), 
         lty = c(1,1,1,3))

points(x = c(mle$dats[1:mle$sims],mle$dats[1:mle$sims],mle$dats[1:mle$sims]),
       y = c(mle$dat1[1:mle$sims],mle$dat2[1:mle$sims],mle$dat3[1:mle$sims]), 
       pch = 16, 
       col = rep(c(alpha('blue', 1),
                   alpha('darkgreen', 1),
                   alpha('red', 1)), 
                 each = length(1:mle$sims)))

text(x = rep(72.5,3),
     y = c(0.025,0.0225, 0.02), 
     c(round(sum(log(mle$dat1)), digits = 4), 
       round(sum(log(mle$dat2)), digits = 4), 
       round(sum(log(mle$dat3)), digits = 4)), 
     col = c('blue', 'darkgreen', 'red'), 
     adj = 0)
dat5 <- max(c(round(sum(log(mle$dat1)), digits = 4), 
              round(sum(log(mle$dat2)), digits = 4), 
              round(sum(log(mle$dat3)), digits = 4)))

if (dat5==round(sum(log(mle$dat1)), digits = 4)) points(52.5,.0250,
                                                        pch = 16, 
                                                        col = 'blue') 
if (dat5==round(sum(log(mle$dat2)), digits = 4)) points(52.5,.0225,
                                                        pch = 16, 
                                                        col = 'darkgreen') 
if (dat5==round(sum(log(mle$dat3)), digits = 4)) points(52.5,.0200,
                                                        pch = 16, 
                                                        col = 'red')

axis(side = 1, 
     labels = paste('t = ', round(mle$dats[mle$sims], digits = 2), sep = ""), 
     at = mle$dats[mle$sims], 
     line = 0, tck = 0)
axis(side = 2, 
     labels = c(round(mle$dat1[mle$sims], digits = 4),
                round(mle$dat2[mle$sims], digits = 4),
                round(mle$dat3[mle$sims], digits = 4)),
     hadj = 0.6, 
     at = c(mle$dat1[mle$sims],
            mle$dat2[mle$sims],
            mle$dat3[mle$sims]), 
     las = 1, 
     col = c('blue','darkgreen','red'), 
     tck = 0)
} 
})
}) 
}
