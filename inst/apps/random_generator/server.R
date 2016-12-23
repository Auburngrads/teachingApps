server = function(input, output, session) {

    output$prn <- DT::renderDataTable({
      
      PRNG <- data.frame(set1,set2,set3, set4)
      
      rownames(PRNG) <- 1:8
      colnames(PRNG) <- c('Set 1 (Seed = NULL)', 
                          'Set 2 (Seed = NULL)',
                          'Set 3 (Seed = 42)',
                          'Set 4 (Seed = 42)')
      DT::datatable(PRNG)
})
}