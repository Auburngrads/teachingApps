











load('args.Rdata')
shinyApp(options = list(height = '600px'),
  
  ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                 try(includeCSS(system.file('css',
                                            'my-shiny.css', 
                                            package = 'teachingApps')), silent = TRUE),
    sidebarLayout(
      sidebarPanel(width = 5,
        shinyAce::aceEditor("mlexpplot", 
                            mode = "r", 
                            theme = "github",
                            height = "450px", 
                            fontSize = 16,
                            value = 
"par(font = 2, mar = c(4,5.5,1,1), family = 'serif', cex = 1.5)

obs <- c(4.2564, 0.5319)

theta <- seq(0.25, 10, .05)

joint.prob.exp <- dexp(obs[1], rate = 1/theta)*
                  dexp(obs[2], rate = 1/theta)

plot(theta, joint.prob.exp, 
     xlab = expression(widehat(theta)),
     ylab = expression(prod(t[i],i=1,2)),
     type = 'l', 
     las = 1, 
     lwd = 3, 
     col = 2)

abline(v = sum(obs)/2, lwd = 2, lty = 2)

text(x = sum(obs)/2, 
     y = .005,
     labels = parse(text = paste(c(expression('' %<-% ''), 
                                   sum(obs)/2), 
                                 collapse = '~')),
     adj = 0)"),

        actionButton("mlexpplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("mlexp", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
  output$mlexp <- renderPlot({
      input$mlexpplots
      return(isolate(eval(parse(text=input$mlexpplot))))
})
})
