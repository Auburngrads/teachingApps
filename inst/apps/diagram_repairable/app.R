library(teachingApps)
library( package = 'diagram')










  


shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme), 
              try(includeCSS(system.file('css',
                                         'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "repairplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"Mat2 <- matrix(NA, nrow = 3, ncol = 3)

AA <- as.data.frame(Mat2)
AA[[1,2]] <- 'F[1:0]'
AA[[1,3]] <- 'F[2:0]'
AA[[2,1]] <- 'F[0:1]'
AA[[3,1]] <- 'F[0:2]'

name <- c(expression(0[Alive]), 
          expression(1[Failed]), 
          expression(2[Failed]))

par(family='serif', mar = c(0,0,0,0))

diagram::plotmat(A = AA, pos = 3, curve = .575, 
         name = name, lwd = 2, arr.len = 0.6, 
         arr.width = 0.25, my = .05, box.size = 0.08, 
         arr.type = 'triangle', dtext = -1,
         relsize=.99,box.cex=1.5,cex=1.25)"),

        actionButton("evalrepair", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotrepair", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
  
observeEvent(input$evalrepair, { 

  output$plotrepair <- renderPlot({
    par(mar = c(0,0,0,0))
      
    return(isolate(eval(parse(text=input$repairplot))))
})
})
})
