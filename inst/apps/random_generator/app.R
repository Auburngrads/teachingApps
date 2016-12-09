library(teachingApps)
library('DT')

set.seed(NULL) ; set1 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(NULL) ; set2 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(42)   ; set3 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(42)   ; set4 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Pseddorandom Observations',
                theme = shinythemes::shinytheme(theme = getShinyOptions("theme")),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(getShinyOptions("appName"))),
                  
    tabPanel(h4('PRN Data'), DT::dataTableOutput('prn'))),
  
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
})
