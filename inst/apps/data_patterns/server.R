server = function(input, output, session) {

if(!global$story)  
output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
output$plotpdflike <- renderPlot({
      input$evalpdflike      
      return(isolate(eval(parse(text=input$pdflikeplot))))
})
}