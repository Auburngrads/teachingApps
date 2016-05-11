stress_strength <-
function(...) {
  
  if(!isNamespaceLoaded('shiny')) attachNamespace('shiny')
  
shinyApp(options = list(width = "100%", height = "350px"),
  ui = fluidPage(theme = shinythemes::shinytheme("flatly"),  
                try(includeCSS('css/my-shiny.css'), silent = TRUE),
    sidebarLayout(
    sidebarPanel(
      sliderInput("mean", 
                  label = h2("Applied Stress:"),
                  min = 5, 
                  max = 16, 
                  value = 5, 
                  step = 1, 
                  animate=TRUE)),
    mainPanel(plotOutput("first", height = "300px")))),

server <- function(input, output, session) {
 
  output$first <- renderPlot({
  jkf.par(mar = c(2,4,2,2))
  plot(seq(0,30,.1),dnorm(seq(0,30,.1),input$mean,2),
       xlim=range(0,22),
       ylim=range(0,.2),
       ylab="", 
       xlab="Stress",
       type="l",
       lwd=2,
       col="blue")
  segments(17,0,17,.3,col="red",lwd=4)
  polygon(c(17,seq(17,22,.1),22),c(0,dnorm(seq(17,22,.1),input$mean,2),0),
          col=rgb(1,0,0,.25),border=NA)
  text(18.5,.19,"Stress Limit",font=2,cex=1.5)
})
})
}
