library(teachingApps)
library('SMRD')

shinyApp(options = list(height = "600px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
      
  ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme), 
                    tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                     
       sidebarLayout(
         sidebarPanel(width = 5,
                      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "berkprofile200", 
                                     mode = "r", 
                                     theme = "github", 
                                     height = "450px", 
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

        actionButton("berk200profiles", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("berk200prof", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
  output$berk200prof <- renderPlot({
      input$berk200profiles
      return(isolate(eval(parse(text=input$berkprofile200))))
})
})
