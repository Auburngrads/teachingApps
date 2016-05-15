figure2_1 <-
function(...) {

try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("fig1plot", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2)

try(attachNamespace('SMRD'), silent = TRUE)

distribution.plot('Weibull',
shape=c(1.7), ## Change this value or add more
scale=c(1),   ## Change this value or add more
prob.range=c(.000001,.99),
my.title='')"),
              actionButton("evalfig1", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfig1", height = "600px")))),
server = function(input, output, session) {
  try(attachNamespace('SMRD'), silent = TRUE)

output$plotfig1 <- renderPlot({
      input$evalfig1
      return(isolate(eval(parse(text=input$fig1plot))))
})
})
}
