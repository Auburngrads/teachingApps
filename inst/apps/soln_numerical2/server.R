server = function(input, output, session) {

if(!source('args.R')[[1]]$story)    
output$sign <- renderUI({HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName))})
  
output$mlsolns <- renderPrint({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlsolnum
      return(isolate(eval(parse(text=input$solnum))))
})
}