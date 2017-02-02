server = function(input, output, session) {

  output$plotrepair <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalrepair
    return(isolate(eval(parse(text=input$repairplot))))
})
}