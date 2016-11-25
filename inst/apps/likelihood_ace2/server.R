server = function(input, output, session) {

if(!source('args.R')[[1]]$story)    
output$sign <- renderUI({HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName))})
  
output$plotlike2 <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike2      
      return(isolate(eval(parse(text=input$likeplot2))))
})
}