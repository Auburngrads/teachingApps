shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig5plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"x<-seq(0,2.4,by=.01)\npar(family='serif', font=2,bg=NA)\ny<-function(t) {pweibull(t,shape=1.7,scale=1)}\n\n
plot(x, y(x), type = 'l',lwd = 2,\nxlab = 't',ylab = 'f(t)', las = 1)\n
segments(c(0,.5,1,1.5,2,rep(0,5)),
         c(rep(0,5),y(c(0.01,.5,1,1.5,2))),
         c(0,.5,1,1.5,2,rep(2.2,5)),
         rep(y(c(0.01,.5,1,1.5,2)),2),
         lty=rep(2,10),col=rep(1,10))\n\n
text(2.3,(y(0.5)+y(.01))/2,expression(pi[1]),cex=1.25)
text(2.3,(y(1.0)+y(0.5))/2,expression(pi[2]),cex=1.25)
text(2.3,(y(1.5)+y(1.0))/2,expression(pi[3]),cex=1.25)
text(2.3,(y(2.0)+y(1.5))/2,expression(pi[4]),cex=1.25)
box(lwd=1.25)\n\n
mtext(side = 3,
      expression('Figure 2.5 - Graphical interpretation of the relationship between the '*pi[i]*' values and F('*t[i]*')'),
      font = 2,line = 2)"),
              actionButton("evalfig5", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfig5", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  

  
  output$plotfig5 <- renderPlot({
      input$evalfig5
      return(isolate(eval(parse(text=input$fig5plot))))
})
})
