cumhazard_demo <- function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(width = "100%", height = "600px"),
         
  ui = fluidPage(theme = shinythemes::shinytheme("flatly"), 
                 try(includeCSS(system.file('css',
                                            'my-shiny.css', 
                                            package = 'teachingApps')), silent = TRUE),
       sidebarLayout( 
          sidebarPanel(
              shinyAce::aceEditor("HAZplot", 
                                  mode = "r", 
                                  theme = "github", 
                                  height = "450px", 
                                  fontSize = 15,
                                  value = 
"par(family='serif',mar = c(4,6,2,1))
                
curve(
-log(1-pgamma(x, shape = 3, rate = 1.5)),
xlab = 'Time, t',
ylab = expression(H(t)[Gamma]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 5,
col = 6,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
                              
        actionButton("evalHAZ", h4("Evaluate"), width = '100%')),
                            
        mainPanel(plotOutput("plotHAZ", height = "600px")))),
           
server = function(input, output, session) {
             
output$plotHAZ <- renderPlot({

  input$evalHAZ
  return(isolate(eval(parse(text=input$HAZplot))))
})
})
} 