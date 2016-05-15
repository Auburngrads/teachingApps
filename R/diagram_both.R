diagram_both <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  try(attachNamespace('diagram'), silent = TRUE)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
              try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("realplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          fontSize = 15,
                          value = 
"DiffMat <- matrix(NA, nrow = 4, ncol = 4)

AA <- as.data.frame(DiffMat)
AA[[1,2]] <- 'F[1:0]'
AA[[1,3]] <- 'F[2:0]'
AA[[2,1]] <- 'F[0:1]'
AA[[3,1]] <- 'F[0:2]'
AA[[4,1]] <- 'F[0:3]'

name <- c(expression(0[Alive]), 
          expression(1[Failed]), 
          expression(2[Failed]), 
          expression(3[Dead]))

par(family='serif', mar = c(0,0,0,0))

diagram::plotmat(A = AA, pos = 4, curve = .575, 
         name = name, lwd = 2, arr.len = 0.6, 
         arr.width = 0.25, my = .15, box.size = 0.08, 
         arr.type = 'triangle', dtext = -1,
         relsize=.99, box.cex=1.5, cex=1.25)"),

        actionButton("evalreal", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotreal", height = "600px"), width = 7))),

server = function(input, output, session) {

    output$plotreal <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalreal
      return(isolate(eval(parse(text=input$realplot))))
})
})
}
