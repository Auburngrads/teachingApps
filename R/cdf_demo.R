cdf_demo <-
function(...) {
  
loadNamespace(shiny)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), includeCSS('css/my-shiny.css'),
  sidebarLayout( 
    sidebarPanel(width = 4,
      shinyAce::aceEditor("cdfplot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "par(family='serif',mar = c(4,6,2,1))

curve(
pweibull(x,shape = 1.7, scale = 1),
xlab = 'Time, t',
ylab = expression(F(t)[Weibull]),
ylim = c(0,1),
xlim = c(0,3),
lwd = 3,
lty = 1,
col = 2,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
              actionButton("evalcdf", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotcdf", height = "600px"), width = 8))),
server = function(input, output, session) {

output$plotcdf <- renderPlot({
      input$evalcdf
      return(isolate(eval(parse(text=input$cdfplot))))
})
})
}
