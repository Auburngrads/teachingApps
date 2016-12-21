server = function(input, output, session) {

if(!getShinyOption("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
output$plotpdflike <- renderPlot({
      input$evalpdflike      
      return(isolate(eval(parse(text=input$pdflikeplot))))
})
}