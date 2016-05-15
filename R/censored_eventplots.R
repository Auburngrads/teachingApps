censored_eventplots <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(width = '100%', height = '600px'),
         
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                 try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
    sidebarLayout(
      sidebarPanel(
      shinyAce::aceEditor("eventplots", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"library(SMRD)

lfp1370.ld <- frame.to.ld(SMRD::lfp1370,
              response.column = 1, 
              censor.column = 2, 
              case.weight.column = 3,
              data.title = 'Integrated Circuit Failure Data After 1370 Hours',
              time.units = 'Hours')

turbine.ld <- frame.to.ld(SMRD::turbine,
              response.column = 1, 
              censor.column = 2,
              case.weight.column = 3,
              data.title = 'Turbine Wheel Crack Initiation Data',
              time.units = 'Hundreds of Hours')

par(mfrow=c(1,2),family='serif',font=2,bg=NA)

event.plot(lfp1370.ld)
event.plot(turbine.ld) 

par(mfrow=c(1,1))"),

        actionButton("evaleventplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("ploteventplots", height = "600px")))),

server = function(input, output, session) {

output$ploteventplots <- renderPlot({
      input$evaleventplots
      return(isolate(eval(parse(text=input$eventplots))))
})
})
}
