library(teachingApps)
library('SMRD')










  


shinyApp(options = list(height = "600px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))}, 
ui = fluidPage(theme = shinythemes::shinytheme(theme = getShinyOptions("theme")), 
               tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "plots", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(family='serif',font=2,cex=1.75)

library(SMRD)

p<- seq(.01,.99,.01)

plot(qweibull(p,.5,50), qsev(p),
     type='l',
     lwd = 2,
     col = 1,
     xlim = c(1,1000),
     las = 1,
     xlab='Time',
     ylab='Standard SEV Quantile',
     log='x')

lines(qweibull(p,0.5,500), 
      qsev(p), lwd = 2, col = 2)
lines(qweibull(p,1.0,500), 
      qsev(p), lwd = 2, col = 3)
abline(h=0, lty=2)

box(lwd=1.25)
legend('bottomright',
       c(expression(eta*','*beta*' = 50,0.5'),
         expression(eta*','*beta*' = 500,0.5'),
         expression(eta*','*beta*' = 500,1.0')),
       lty = 1,col = c(1:3), lwd = 2, bty = 'n')"),

        actionButton("evalplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("lnorm", height = "600px"))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  

  
  output$lnorm <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
})
