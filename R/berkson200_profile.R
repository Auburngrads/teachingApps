berkson200_profile <-
function(...) {
  
  loadNamespace('shiny')
  
shinyApp(options = list(height = '600px'),
      
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                     includeCSS('css/my-shiny.css'),
                     
       sidebarLayout(
         sidebarPanel(shinyAce::aceEditor("berkprofile200", 
                                          mode = "r", 
                                          theme = "github", 
                                          height = "450px", 
                                          fontSize = 16,
                                          value = 
"par(family  = 'serif')

library(SMRD)

berkson200.ld <- 
frame.to.ld(SMRD::berkson200,
            response.column = c(1,2),
            censor.column = 3,
            case.weight.column = 4,
            data.title = 'Times Between Alpha Particle Arrival (n=200)',
            time.units = '1/5000 Seconds')

berkson200.mle.exp <- expon.mle(berkson200.ld)

one.dim.profile(berkson200.mle.exp, 
                size = 200,
                range.list = list(log(c(450,800))),
                print.ci = FALSE)

### NOTE: `one.dim.profile` will give the upper and 
###        lower confidence limits if `print.ci = TRUE`"),

actionButton("berk200profiles", h4("Evaluate"), width = '100%'), width = 5),
        
        mainPanel(plotOutput("berk200prof", height = "600px"), width = 7))),

server = function(input, output, session) {
  
  output$berk200prof <- renderPlot({
      input$berk200profiles
      return(isolate(eval(parse(text=input$berkprofile200))))
})
})
}
