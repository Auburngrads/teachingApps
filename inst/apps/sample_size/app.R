library(teachingApps)
library('SMRD')










  


shinyApp(options = list(height = '600px', width = '100%'),
    
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
     sidebarLayout(
        sidebarPanel(width = 5,
           shinyAce::aceEditor(fontSize = 16, 
                               wordWrap = T,
                               outputId = "samps", 
                               mode = "r", 
                               theme = "github", 
                               height = "450px", 
                               value = "
N <- 100
n <- 10
pop <- rweibull(N, scale = 10, shape = 2.3)
plot(density(pop, from = 0, to = 30), 
     xaxt = 'n', yaxt = 'n', 
     xlab = '', ylab = '', main = '', 
     bty = 'n', lwd = 3, col = 4,
     xaxs = 'i', yaxs = 'i')
axis(side = 1, labels = F, at = pop, tck = -0.05, col = 4)
samp <- sample(pop, size = n)
lines(density(samp, from = 0, to = 30), col = 2, lwd = 3)
axis(side = 1, labels = F, at = samp, tck = 0.05, col = 2)
legend('topright', 
       legend = c(paste(c('Population (N = ',length(pop),')'), collapse = ''),
                  paste(c('Sample      (n  = ', length(samp), ')'), collapse = '')),
       col = c(4,2),
       lwd = 3,
       bty = 'n',
       cex = .9)"),

        actionButton("berks", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("samps", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
  
observeEvent(input$berks, {

  output$berkint <- renderPlot({
      
      return(isolate(eval(parse(text=input$berkint))))
})
})
})
