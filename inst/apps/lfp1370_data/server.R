server = function(input, output, session) {
  
  output$lfp1370 <- DT::renderDataTable({DT::datatable(SMRD::lfp1370,
                                                       options = list(pageLength = 10))})

  output$plotlfpevent <- renderPlot({
      input$evallfpevent
      return(isolate(eval(parse(text=input$lfpeventplot))))
})

  output$plotlfpcdf <- renderPlot({
      input$evallfpcdf
      return(isolate(eval(parse(text=input$lfpcdfplot))))
})
}