exp_numerical <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(height = '750px', width = '99%'),
    
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'), includeCSS('css/my-shiny.css'),
        sidebarLayout(
          sidebarPanel(shinyAce::aceEditor("mlexpnum", mode = "r", theme = "github", 
                                           height = "590px", fontSize = 20,
value = "obs <- c(4.2564, 0.5319)

joint.exp <- function(x, param) { 
  
  Fun <- prod(dexp(x[1:length(x)],1/param))
  
  return(-Fun)

}

nlminb(start = 4, 
       objective = joint.exp, 
       x = obs)"),

actionButton("mlexpnums", h4("Evaluate")), width = 6),
        
        mainPanel(verbatimTextOutput("mlexp2"), width = 6))),

server = function(input, output, session) {
  
  output$mlexp2 <- renderPrint({
      input$mlexpnums
      return(isolate(eval(parse(text=input$mlexpnum))))
})
})
}
