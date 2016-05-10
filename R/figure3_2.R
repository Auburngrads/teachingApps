figure3_2 <-
function(...) {
  
  loadNamespace('shiny')
  
shinyApp(options = list(height = '600px', width = '100%'),
    ui = fluidPage(theme = shinythemes::shinytheme('flatly'),includeCSS('css/my-shiny.css'),
    sidebarLayout(
      sidebarPanel(
        shinyAce::aceEditor("npplot", mode = "r", theme = "github", height = "475px", fontSize = 14,
                      value = "par(family = 'serif', font = 2, cex = 1.15)
loadNamespace(SMRD)
HE.ld <- frame.to.ld(heatexchanger,
                     response.column = c(1,2), 
                     censor.column = 3,
                     case.weight.column = 4,
                     data.title = 'Heat Exchanger Crack Data',
                     time.units = 'Years')
plot(HE.ld,band.type = 'Pointwise')"),
              actionButton("eval3.2", h4("Evaluate"))),
        
        mainPanel(plotOutput("plot3.2", height = "600px")))),
server = function(input, output, session) {
loadNamespace(SMRD)
output$plot3.2 <- renderPlot({
      input$eval3.2
      return(isolate(eval(parse(text=input$npplot))))
})
})
}
