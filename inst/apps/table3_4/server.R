server = function(input, output, session) {
  
  output$table.shock1 <- DT::renderDataTable({
    
    DT::datatable(SMRD::shockabsorber, 
                  rownames = F,
                  options = list(pageLength = 13))
})
  output$table.shock2 <- DT::renderDataTable({
    
    DT::datatable(Table.3.4, 
                  rownames = FALSE,
                  options = list(pageLength = 13))
})
}