server = function(input, output, session) {

  output$plotreplace <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalreplace
    return(isolate(eval(parse(text=input$replaceplot))))
})
}