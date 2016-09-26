load('args.Rdata')
shinyApp(options = list(height = "800px"),
         
ui = navbarPage(theme = shinythemes::shinytheme(theme = arg2$theme),
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = T),
                
tabPanel(h4("Add Text"),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "textcode", 
                                mode = "r", 
                                theme = "github", 
                                height = "475px", 
                                value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

text(x = 10, y = 5,
     'Text will print at the location specified',
     adj = 0.5,
     font = 0,
     family = 'serif')

#font = 1 (normal)
#font = 2 (bold)
#font = 3 (italic)
#font = 4 (bold-italic)"),

    actionButton("texteval", h2("Evaluate"), width = '100%')),
        
    mainPanel(plotOutput("text", height = "550px"), width = 7))),

tabPanel(h4("Add Equations"),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = 
                                "eqncode", 
                                mode = "r", 
                                theme = "github",
                                height = "475px", 
                                value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

text(x = 10,y = 5,
expression(pi%~~%frac(22,7)+
           exp(Omega^2)-bold(R[d])*
           integral(lim(f(x), x %->% 0)*dx, a, b)),
     adj = 0.5,
     font = 0,
     family = '')"),

   actionButton("eqneval", h2("Evaluate"), width = '100%')),
        
   mainPanel(plotOutput("eqn", height = "550px"), width = 7))),

tabPanel(h4("Add Points"),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "ptcode", 
                                mode = "r", 
                                theme = "github", 
                                height = "475px", 
                                value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8, 
       pch = 16, 
       col = 'gold')
points(c(10,5), c(14,27),
       cex = 2, 
       pch = '$', 
       col = 'white')"),
       
 actionButton("pteval", h2("Evaluate"), width = '100%')),
        
 mainPanel(plotOutput("point", height = "550px"), width = 7))),

tabPanel(h4("Add Lines"),
   sidebarLayout( 
      sidebarPanel(htmlOutput('lineace'),
                   htmlOutput('lineact')),
        
  mainPanel(
    tabsetPanel(id = 'lines',
       tabPanel(h4("Add Lines 1"), value = 'lines1',
          plotOutput('abline0', height = '550px')),
       tabPanel(h4('Add Lines 2'), value = 'lines2',
          plotOutput('abline1', height = '550px')),
       tabPanel(h4('Add Lines 3'), value = 'lines3',
          plotOutput('abline2', height = '550px')))))),

tabPanel(h4("Add A Grid"),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "gridcode", 
                                mode = "r", 
                                theme = "github", 
                                height = "475px", 
                                value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8, 
       pch = 16, 
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2, 
       pch = '$', 
       col = 'white')

grid(10,10)"),
       
  actionButton("grideval", h2("Evaluate"), width = '100%')),
        
  mainPanel(plotOutput("grid", height = "550px"), width = 7))),

tabPanel(h4("Add A Legend"),
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "legcode", 
                                mode = "r", 
                                theme = "github", 
                                height = "475px",
                                value = 
"set.seed(4)

x1<-sort(sample(1:50,size = 10))
y1<-sort(sample(1:50,size = 10))
x2<-sort(sample(1:50,size = 10))
y2<-sort(sample(1:50,size = 10))

plot(x1,y1,pch = 16, col = 2,
xlim = c(0,50),
ylim = c(0,50))
points(x2,y2,pch = 16, col = 4)

legend('topright',
       c('Series 1','Series 2'),
       pch = 16, col = c(2,4),
       bty = 'o')"),

  actionButton("legeval", h2("Evaluate"), width = '100%')),
        
  mainPanel(plotOutput("legend", height = "550px"), width = 7))), 
  
fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
    
  output$text <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$texteval
      return(isolate(eval(parse(text=input$textcode))))
})
  output$eqn <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$eqneval
      return(isolate(eval(parse(text=input$eqncode))))
})
  output$point <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$pteval
      return(isolate(eval(parse(text=input$ptcode))))
})
output$abline0 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$lineeval
      return(isolate(eval(parse(text=input$linecode))))
})
output$abline1 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$abeval1
      return(isolate(eval(parse(text=input$abcode1))))
})
output$abline2 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$abeval2
      return(isolate(eval(parse(text=input$abcode2))))
})
output$lineace <- renderUI({ switch(input$lines,
                           
    'lines1' = {
    
    shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = 
                        "linecode", 
                         mode = "r", 
                         theme = "github", 
                         height = "475px", 
                         value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8,
       pch = 16,
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2,
       pch = '$',
       col = 'white')

lines(c(10,5), c(14,27),
      lwd = 2,
      col = 'green')")},
      
  'lines2' = { 
    
    shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = 
                        "abcode1", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px", 
                        value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8,
       pch = 16,
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2,
       pch = '$',
       col = 'white')

abline(a = 10, b = 3,
       lwd = 2, 
       col = 'green')")},
    
 'lines3' = {
    
    shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = 
                        "abcode2", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px", 
                        value = 
"set.seed(NULL)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y)

points(c(10,5), c(14,27),
       cex = 8, 
       pch = 16, 
       col = 'gold')

points(c(10,5), c(14,27),
       cex = 2, 
       pch = '$', 
       col = 'white')

abline(h = 10, v = 30,
       lwd = 2, 
       col = 'green')")})
})
output$lineact <- renderUI({ switch(input$lines,
                           
  'lines1' = { actionButton("lineeval", h2("Evaluate"), width = '100%')},

  'lines2' = { actionButton("abeval1", h2("Evaluate"), width = '100%')},
  
  'lines3' = { actionButton("abeval2", h2("Evaluate"), width = '100%')})
})
  output$grid <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$grideval
      return(isolate(eval(parse(text=input$gridcode))))
})
  output$legend <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$legeval
      return(isolate(eval(parse(text=input$legcode))))
})
})
