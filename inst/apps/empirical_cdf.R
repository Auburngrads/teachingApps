empirical_cdf <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(height = '650px'),
         
ui = fluidPage(theme = shinythemes::shinytheme('flatly'),
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = T),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor("code", 
                                mode = "r", 
                                theme = "github", 
                                fontSize = 15, 
                                height = '500px',
                                value = 
"beta <- 2
theta <- 15

v <- rweibull(100, shape = beta, scale = theta)

plot(ecdf(v),
     xlab = '', 
     main = '',
     col = 'blue')

curve(pweibull(x, shape = beta, scale = theta), 
      add = TRUE,
      lwd = 2,
      col = 2)

axis(side = 1, at = v, labels = F)"),

          actionButton("eval", h3("Evaluate"))),
        
          mainPanel(plotOutput("output", height = '600px')))),
  
server = function(input, output, session) {
  
    output$output <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(3.5,4,2,2))
      input$eval
      return(isolate(eval(parse(text=input$code))))
})  
})
}
