server = function(input, output, session) {

if(!getShinyOptions("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
output$plotpdflike <- renderPlot({
      input$evalpdflike      
      return(isolate(eval(parse(text=input$pdflikeplot))))
})
}