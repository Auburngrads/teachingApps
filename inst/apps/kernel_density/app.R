library(teachingApps)














shinyApp(options = list(height = "600px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme),
              tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "code", 
                                mode = "r", 
                                theme = "github", 
                                 
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

          actionButton("eval", h4("Evaluate"), width = '100%')),
        
          mainPanel(plotOutput("output", height = '600px'))),
  
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
    output$output <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(3.5,4,2,2))
      input$eval
      return(isolate(eval(parse(text=input$code))))
})  
})
