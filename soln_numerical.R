soln_numerical <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(height = '750px', width = '99%'),
    
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'), includeCSS('css/my-shiny.css'),
        sidebarLayout(
          sidebarPanel(shinyAce::aceEditor("solnum", mode = "r", theme = "github", 
                                           height = "590px", fontSize = 20,
value = "obs <- c(4.2564, 0.5319)

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
  
  return(-eval(parse(text = Fun)))
}

nlminb(start = c(4,2), 
       objective = joint.prob, 
       x = obs)"),

actionButton("mlsolnum", h4("Evaluate")), width = 6),
        
        mainPanel(verbatimTextOutput("mlsolns"), width = 6))),

server = function(input, output, session) {
  
  output$mlsolns <- renderPrint({
      input$mlsolnum
      return(isolate(eval(parse(text=input$solnum))))
})
})
}
