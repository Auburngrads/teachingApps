server = function(input, output, session) {

    output$amt <- DT::renderDataTable({
      
      DT::datatable(mtcars, 
                    options = list(pageLength = 8))
})
}