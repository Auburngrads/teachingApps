library(teachingApps)
library('scales')
library(markdown) 
  options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))
library(knitr)

shinyApp(options = list(height = "800px"),
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Maximum Likelihood',
                theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
                header = tags$head(tags$style(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps')))),
                footer = HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName)),
                

tabPanel(h4('Background'), 
  fluidRow(
    column(width = 12,
           mainPanel(uiOutput('mleback1'), class = 'shiny-text-output', width = '100%')))),

tabPanel(h4('Simple Example'),  
fluidRow(
    column(width = 12,
           mainPanel(uiOutput('example1_1'), class = 'shiny-text-output', width = '100%'))),
fluidRow(
  column(width = 12, titlePanel('To change the plot update the code and click "Evaluate" '))),
fluidRow(
  column(width = 5,
         sidebarPanel(width = '100%',
         shinyAce::aceEditor(fontSize = 16, 
                              wordWrap = T,
                              outputId = "likeplot", 
                              mode = "r", 
                              theme = "github", 
                              height = "450px", 
                              value ="
curve(dexp(x, rate = 1), 
      lwd = 2, col = 1, 
      xlim = c(0,5), 
      ylim = range(0,.9), 
      xlab = 'Time (t)', 
      ylab = 'f(t)',
      las = 1, 
      cex.lab = 1.5,
      cex.axis = 1.5)

curve(dweibull(x, shape = 1.5), lwd = 2, col = 4, lty = 2, add = T)

points(x = c(0.5,0.5),
       y = c(dexp(0.5, rate = 1), dweibull(0.5,shape = 1.5)), 
       cex = 1.5, 
       pch = 16, 
       col = 2)

text(x = c(0.5,0.5),
     y = c(dweibull(0.5, shape = 1.5)+.005,
           dexp(0.5, rate = 1)+.005),
     labels = c(parse(text = paste('NA%<-%~',dweibull(0.5, shape = 1.5))),
                parse(text = paste('NA%<-%~',dexp(0.5, rate = 1)))),
     adj = -0.15,
     cex = 1.5)

abline(v = 0.5, col = 2)

legend('topright',
       c(parse(text = 'exp(theta==1)'),
         parse(text = 'Weib(beta,theta==1.5,1)')), 
       lwd = 2, 
       col = c(1,4), 
       bty = 'n', 
       lty = c(1,2),
       y.intersp = 1.5,
       cex = 1.4)"),

   actionButton("evallike", h4("Evaluate"), width = '100%'))),
   
 column(width = 7,
        mainPanel(plotOutput('plotlike', height = '600px'), width = '100%'))),
 
fluidRow(
 column(width = 12,
           mainPanel(uiOutput('example1_2'), class = 'shiny-text-output', width = '100%'))),
 
fluidRow( 
 column(width = 12, titlePanel('To change the plot update the code and click "Evaluate" ')),
 column(width = 5,
        sidebarPanel(width = '100%',
        shinyAce::aceEditor(fontSize = 16, 
                              wordWrap = T,
                              outputId = "likeplot2", 
                              mode = "r", 
                              theme = "github", 
                              height = "450px", 
                              value ="
curve(dexp(x, rate = 1), 
      lwd = 2, col = 1, 
      xlim = c(0,5), 
      ylim = range(0,.9), 
      xlab = 'Time (t)', 
      ylab = 'f(t)',
      las = 1, 
      cex.lab = 1.5,
      cex.axis = 1.5)

curve(dweibull(x, shape = 1.5), lwd = 2, col = 4, lty = 2, add = T)

points(x = c(0.2,0.2),
       y = c(dexp(0.2, rate = 1), dweibull(0.2,shape = 1.5)), 
       cex = 1.5, 
       pch = 16, 
       col = 3)

text(x = c(0.1,0.1),
     y = c(dweibull(0.2, shape = 1.5)+.005,
           dexp(0.2, rate = 1)+.005),
     labels = c(parse(text = paste('NA%<-%~',dweibull(0.2, shape = 1.5))),
                parse(text = paste('NA%<-%~',dexp(0.2, rate = 1)))),
     adj = -0.15,
     cex = 1.5)

abline(v = 0.2, col = 3)

legend('topright',
       c(parse(text = 'exp(theta==1)'),
         parse(text = 'Weib(beta,theta==1.5,1)')), 
       lwd = 2, 
       col = c(1,4), 
       bty = 'n', 
       lty = c(1,2),
       y.intersp = 1.5,
       cex = 1.4)"),

   actionButton("evallike2", h4("Evaluate"), width = '100%'))),
 
 column(width = 7,
        mainPanel(plotOutput('plotlike2', height = '600px'), width = '100%'))),

fluidRow( 
 column(width = 12,
           mainPanel(uiOutput('example1_3'), class = 'shiny-text-output', width = '100%')))),

tabPanel(h4('Silly Example'),
fluidRow( 
 column(width = 12,
        mainPanel(uiOutput('example2_1'), class = 'shiny-text-output', width = '100%'))),

fluidRow(
 column(width = 5,
   sidebarPanel(width = '100%',
                shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "mlexpplot", 
                            mode = "r", 
                            theme = "github",
                            height = "450px", 
                            value = 
"
set.seed(as.numeric(Sys.Date()))

obs <- runif(2,0.5,4.5)

theta <- seq(0.25, 10, .05)

joint.prob.exp <- dexp(obs[1], rate = 1/theta)*
                  dexp(obs[2], rate = 1/theta)

plot(theta, joint.prob.exp, 
     xlab = expression(widehat(theta)),
     ylab = expression(prod(t[i],i=1,2)),
     type = 'l', 
     las = 1, 
     lwd = 3, 
     col = 2)

abline(v = sum(obs)/2, lwd = 2, lty = 2)

text(x = sum(obs)/2, 
     y = .005,
     labels = parse(text = paste(c(expression('' %<-% ''), 
                                   sum(obs)/2), 
                                 collapse = '~')),
     adj = 0)"),

        actionButton("mlexpplots", h4("Evaluate"), width = '100%'))),

 column(width = 7,
    mainPanel(plotOutput("mlexp", height = "600px"), width = '100%'))),

fluidRow( 
 column(width = 12,
           mainPanel(uiOutput('example2_2'), class = 'shiny-text-output', width = '100%'))),

fluidRow(
 column(width = 5,
   sidebarPanel(width = '100%',
                shinyAce::aceEditor(fontSize = 16, 
                                    wordWrap = T,
                                    outputId = "mlexpnum", 
                                    mode = "r", 
                                    theme = "github", 
                                    height = "500px", 
                                    value = 
"set.seed(as.numeric(Sys.Date()))

obs <- runif(2,0.5,4.5)

joint.exp <- function(x, param) { 
  
  Fun <- prod(dexp(x[1:length(x)],1/param))
  
  return(-Fun)   }

nlminb(start = 4, 
       objective = joint.exp, 
       x = obs)[1:5]

# $par shows that the value of theta at which
##  the likelihood function is maximized

## $objective shows the value of the 
## likelihood function when theta = $par 

## Why is $objective negative?"),

        actionButton("mlexpnums", h4("Evaluate"), width = '100%'))),

 column(width = 7,
    mainPanel(verbatimTextOutput("mlexp2"), width = '100%'))),

fluidRow( 
 column(width = 12,
           mainPanel(uiOutput('example2_3'), class = 'shiny-text-output', width = '100%'))),

fluidRow(
 column(width = 5,
   sidebarPanel(width = '100%',
                shinyAce::aceEditor(fontSize = 16, 
                                    wordWrap = T,
                                    outputId = "solnum", 
                                    mode = "r", 
                                    theme = "github", 
                                    height = "530px", 
                                    value = 
"set.seed(as.numeric(Sys.Date()))

obs <- runif(2,0.5,4.5)

model <- 'normal'

distro <- 
switch(tolower(model), 
'norm'  =, 'nor'  =, 'normal'    = 'dnorm',
'lnorm' =, 'lnor' =, 'lognormal' = 'dlnorm',
           'weib' =, 'weibull'   = 'dweibull')

joint.prob <- function(x,param) { 

Fun <- 
paste(c('prod(',
        distro,
        '(x[1:length(x)], param[1], param[2]))'), 
      collapse = '')
  
  return(-eval(parse(text = Fun)))  }

nlminb(start = runif(2, 1.5, 4.2), 
       objective = joint.prob, 
       x = obs)[1:5]"),

        actionButton("mlsolnum", h4("Evaluate"), width = '100%'))),

 column(width = 7,
    mainPanel(verbatimTextOutput("mlsolns"), width = '100%')))
),
tabPanel(h4("A Simulation"),
sidebarLayout(
  sidebarPanel(width = 4,
    selectInput('correct', 
                label = h2('Choose The True Distribution'), 
                choices = c('Green', 
                            'Blue', 
                            'Red'), 
                selected = 'Blue'),
    HTML('<h2>Generate Some Samples</h2>'),
    actionButton('mlesample',h4('sample 1'), width = '100%'),
    hr(),
    actionButton('mlesample10',h4('sample 10'), width = '100%'),
    HTML('<h2>Or Start Over</h2>'),
    actionButton('clear',h4('clear'), width = '100%')),
  
  mainPanel(plotOutput('plotmle', height = '650px'), width = 8))),

tabPanel(h4('Details'),
fluidRow( 
 column(width = 12,
        mainPanel(uiOutput('details'), class = 'shiny-text-output', width = '100%'))))),

server = function(input, output, session) {

output$mleback1 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('background1.Rmd'))))
})

output$example1_1 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('example1_1.Rmd'))))
})

output$plotlike <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike      
      return(isolate(eval(parse(text=input$likeplot))))
})

output$example1_2 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('example1_2.Rmd'))))
})

output$plotlike2 <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike2      
      return(isolate(eval(parse(text=input$likeplot2))))
})

output$example1_3 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('example1_3.Rmd'))))
})

output$example2_1 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('example2_1.Rmd'))))
})

output$mlexp <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlexpplots
      return(isolate(eval(parse(text=input$mlexpplot))))
})

output$example2_2 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('example2_2.Rmd'))))
})

output$mlexp2 <- renderPrint({
      input$mlexpnums
      return(isolate(eval(parse(text=input$mlexpnum))))
})

output$example2_3 <- renderUI({ 
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('example2_3.Rmd'))))
})

output$mlsolns <- renderPrint({
      input$mlsolnum
      return(isolate(eval(parse(text=input$solnum))))
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

output$details <- renderUI({ withMathJax()
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit('details.Rmd'))))
})
})
