maximum_likelihood_full <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  try(attachNamespace('scales'), silent = TRUE)
  
shinyApp(options = list(height = "800px"),
         
ui = navbarPage(windowTitle = 'Maximum Likelihood',
                theme = shinythemes::shinytheme("flatly"),
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')),silent = TRUE),

tabPanel(h4("ML Estimation"), 
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

tabPanel(h4('Background'),
mainPanel(width = 12, uiOutput('mleback', class = 'shiny-text-output'))),

tabPanel(h4('MLE Properties'),
mainPanel(width = 12, uiOutput('mleprops', class = 'shiny-text-output'))),

tabPanel(h4('Video'),
mainPanel(width = 12, uiOutput('mlevideo', class = 'shiny-text-output'))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApp('maximum_likelihood'))})
  
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
               
  mle$sims <- 1 ; mle$dats <- NULL ; mle$dat1 <- NULL ; mle$dat2 <- NULL ; mle$dat3 <- NULL
  
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
  
  if(input$mlesample10) { 
    
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
})
output$mleback <- renderUI({withMathJax(HTML('
<h3>Maximum Likelihood Estimation</h3>
<ul>
<li>
<p>Is a versitile method of fitting statistical models to data</p>
</li>
<li>
<p>Can be applied to a wide variety of statistical models and data structures</p>
</li>
<li>
<p>Produces efficient and consistent estimator under certain <focus>regularity conditions</focus></p>
<ul>
<li>
<p>Efficient - estimates <script type="math/tex">\\mathbf{\\underline{\\theta}}=\\theta_{1},\\theta_{2},...</script></p>
</li>
<li>
<p>Consistent - <script type="math/tex">\\text{as}\\;n\\rightarrow\\infty, \\;\\;f(\\hat{\\theta}_{_{MLE}}\\xrightarrow{L}\\theta)</script></p>
</li>
</ul>
</ul>

<h3>Maximum Likelihood Regularity Conditions</h3>
<ol style="list-style-type: decimal">
<li><p>The support does not depend on <script type="math/tex">\\theta</script></p></li>
<li><p>Parameters are identifiable <script type="math/tex">\\theta_1\\ne\\theta_2,\\; f(t|\\theta_1)\\ne f(t|\\theta_2), \\;\\forall t</script></p></li>
<li><p>The true value of <script type="math/tex">\\Theta</script></p></li>
<li><p><script type="math/tex">3^{rd}</script></span> mixed partial derivative</p></li>
<li><p><script type="math/tex">E\\left[\\frac{\\partial^{2}\\log(f(t|\\theta))}{\\partial\\theta(\\partial\\theta)^T}\\right]=\\frac{\\partial^2 E\\left[\\log(f(t|\\theta))\\right]}{\\partial\\theta(\\partial\\theta)^T}</script></p></li>
<li><p>Elements of <script type="math/tex">\\mathscr{I}_{\\theta}</script> is a positive-definite matrix</p></li>
</ol>'))
})
output$mleprops <- renderUI({withMathJax(HTML('
<h3>Properties of the Likelihood Function<script type="math/tex">\\mathscr{L}</script></h3>'
))
})
output$mlevideo <- renderUI({withMathJax(HTML('
<h3>A Random Video</h3>
<br>
<center>
<iframe width="672" height="378" src="https://www.youtube.com/embed/3X9mmgknvXw" frameborder="0" allowfullscreen></iframe>
</center>'
))
})
})
}
