











shinyApp(options = list(height = '600px'),
         
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
                                height = '450px',
                                value = 
"library(scales)

beta <- 2
theta <- 15

w <- rweibull(100,
              shape = beta, 
              scale = theta)

plot(density(w),
     lwd = 1,
     xlab = '', 
     main = '')

curve(dweibull(x,
               shape = beta, 
               scale = theta), 
               add = TRUE,
               lwd = 2,
               col = 2)
axis(side = 1, at = w, labels = F)

polygon(density(w)$x,
        density(w)$y,
        col = alpha('lightblue',0.5))"),

          actionButton("eval", h4("Evaluate"))),
        
          mainPanel(plotOutput("output", height = '600px')))),
  
server = function(input, output, session) {
  
    output$output <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(3.5,4,2,2))
      input$eval
      return(isolate(eval(parse(text=input$code))))
})  
})
