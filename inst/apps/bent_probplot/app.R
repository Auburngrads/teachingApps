library(pos = -1,  package = 'SMRD')










  
load('args.Rdata')
shinyApp(options = list(height = '600px', width = '100%'),
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = T),

sidebarLayout(
  sidebarPanel(width = 5,
    shinyAce::aceEditor("bleedplot", 
                        mode = "r", 
                        theme = "github", 
                        height = "450px",
                        value = 
"par(family='serif',font=2, cex=1.75)

Bleed.ld <- frame.to.ld(bleed,
                        response.column = 1, 
                        censor.column = 2, 
                        case.weight.column = 3,
                        x.columns = c(4),
                        data.title = 'Bleed Failure Data',
                        time.units = 'Hours')
plot(Bleed.ld)"),

        actionButton("evalbleedplot", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("bleedplot", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
  output$bleedplot <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalbleedplot
      return(isolate(eval(parse(text=input$bleedplot))))
})
})
