shinyApp(options = list(height = '600px'),
             
ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
               
     sidebarLayout(
        sidebarPanel(width = 5,
           shinyAce::aceEditor("fig56plot", 
                               mode = "r", 
                               theme = "github", 
                               height = "450px", 
                               fontSize = 15,
                               value ="
par(lwd = 2, family = 'serif', las = 1, 
    mgp = c(2.25,0.7, 0), tcl = -0.3, 
    font.lab = 2, font = 2, font.axis = 2, 
    las = 1, tck = 0.015)

curve(dlnorm(x, 0, 0.5), 
      col = 1, 
      n = 300, 
      xlim = c(0,6), 
      ylim = c(0,1.05), 
      xlab = 't', 
      ylab = 'f(t)')
curve(dlnorm(x-1,0,0.5), col = 2, n = 300, add = T)
curve(dlnorm(x-2,0,0.5), col = 3, n = 300, add = T)
curve(dlnorm(x-3,0,0.5), col = 4, n = 300, add = T)

text(x = seq(.797,3.797),
     y = rep(1,4), 
     labels = c(parse(text = 'gamma==0'),
                parse(text = 'gamma==1'),
                parse(text = 'gamma==2'),
                parse(text = 'gamma==3')), 
                col = 1:4, 
                font = rep(2,4))"),

   actionButton("evalfig56", h4("Evaluate"), width = '100%')),

   mainPanel(plotOutput('plotfig56', height = '600px'), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


output$plotfig56 <- renderPlot({
      input$evalfig56
      return(isolate(eval(parse(text=input$fig56plot))))
})
})
