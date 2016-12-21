server = function(input, output, session) {

if(!getShinyOption("story"))    
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
output$mlsolns <- renderPrint({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlsolnum
      return(isolate(eval(parse(text=input$solnum))))
})
}