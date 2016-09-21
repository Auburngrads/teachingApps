











shinyApp(options = list(height = '650px'),
         
ui = fluidPage(theme = shinythemes::shinytheme('flatly'),
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
     sidebarLayout( 
        sidebarPanel(width = 5,
           shinyAce::aceEditor("code", 
                               mode = "r", 
                               theme = "github", 
                               fontSize = 15, 
                               height = '500px',
                               value = 
"set.seed(NULL)

x<-rbinom(500,size = 15,p = .25)

hist(x, col = 1,
     border = 'orange',
     breaks = c(0,1,2,3,4,5,6,7,8,9,10,11),
     main = '')"),

     actionButton("eval", h3("Evaluate"), width = '100%')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)),
  
fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

      output$output <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$eval
      return(isolate(eval(parse(text=input$code))))
})  
})
