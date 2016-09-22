library(pos = -1,  package = 'DT')











set.seed(NULL) ; set1 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(NULL) ; set2 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(42)   ; set3 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(42)   ; set4 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))


shinyApp(options = list(height = '800px', width = '100%'),
  ui = navbarPage(theme = shinythemes::shinytheme(theme = get('theme', envir = .jkf.apps)), 
                  try(includeCSS(system.file('css','my-shiny.css', 
                                             package = 'teachingApps')), silent = TRUE),
                  
    tabPanel(h4('PRN Data'), DT::dataTableOutput('prn')),
  
fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
    
    output$prn <- DT::renderDataTable({
      
      PRNG <- data.frame(set1,set2,set3, set4)
      
      rownames(PRNG) <- 1:8
      colnames(PRNG) <- c('Set 1 (Seed = NULL)', 
                          'Set 2 (Seed = NULL)',
                          'Set 3 (Seed = 42)',
                          'Set 4 (Seed = 42)')
      DT::datatable(PRNG)
})
})
