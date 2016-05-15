exp_numerical <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(height = '750px'),
    
  ui = navbarPage(theme = shinythemes::shinytheme('flatly'), 
                  try(includeCSS(system.file('css',
                                             'my-shiny.css', 
                                             package = 'teachingApps')), silent = TRUE),
       tabPanel(h4('Numerical Solution'),
        sidebarLayout(
          sidebarPanel(width = 6,
                       shinyAce::aceEditor("mlexpnum", 
                                           mode = "r", 
                                           theme = "github", 
                                           height = "500px", 
                                           fontSize = 16,
                                           value = 
"obs <- c(4.2564, 0.5319)

joint.exp <- function(x, param) { 
  
  Fun <- prod(dexp(x[1:length(x)],1/param))
  
  return(-Fun)   }

nlminb(start = 4, 
       objective = joint.exp, 
       x = obs)[1:5]

## $par shows that the value of theta at which
##  the likelihood function is maximized is 2.3941

## $objective shows that the value of the 
## likelihood function when theta = $par is
##  0.023611

## Why is $objective negative?"),

        actionButton("mlexpnums", h4("Evaluate"), width = '100%')),
        
        mainPanel(verbatimTextOutput("mlexp2"), width = 6))),


  tabPanel(h4('Overview of nlminb()'),

        mainPanel(uiOutput("nlminb", class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
  output$mlexp2 <- renderPrint({
      input$mlexpnums
      return(isolate(eval(parse(text=input$mlexpnum))))
})
  
  output$nlminb <- renderUI({HTML(
'<li>R, like most languages, does not maximize functions - but <red>minimizes</red> them</li>

<li>Therefore, to find `maximum` values we minimize the <u>negative</u> of a function</li>

<center><p><focus>This is why the <code>joint.exp()</code> returns a negative<focus></p></center>

<li>This does not change the value of the point at which the maximum value occurs (returned by <code>$par</code>)</li>  

<li>But, we must remember that the value of the likelihood function (returned by <code>$objective</code>) must be multiplied by -1</li>')
})
})
}
