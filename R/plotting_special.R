plotting_special <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(height = "800px"),
         
  ui = navbarPage(theme = shinythemes::shinytheme("flatly"),
                  try(includeCSS(system.file('css',
                                             'my-shiny.css', 
                                             package = 'teachingApps')), silent = T),
tabPanel(h4("Bar Plots"),
   sidebarLayout( 
      sidebarPanel(
         shinyAce::aceEditor("barcode", 
                             mode = "r", 
                             theme = "github", 
                             height = "475px",
                             value = 
"set.seed(NULL)

par(mfrow = c(1,2))

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))
barplot(x, 
        col = rainbow(10),
        names.arg = LETTERS[1:10],
        space = .25)
legend('topleft',
       legend = x,
       fill = rainbow(10),
       bty = 'n')

barplot(y,
        col = heat.colors(10),
        names.arg = letters[1:10],
        space = 0)
legend('topleft',
       legend = y,
       fill = heat.colors(10),
       bty = 'n')"),
       
  actionButton("bareval", h2("Evaluate"), width = '100%')),
        
  mainPanel(plotOutput("barplot", height = "550px")))),

tabPanel(h4("Pie Charts"),
   sidebarLayout( 
      sidebarPanel(
          shinyAce::aceEditor("piecode", 
                              mode = "r", 
                              theme = "github", 
                              height = "475px",
                              value = 

"set.seed(NULL)

par(mfrow = c(1,2))

x<-sort(sample(1:50,size = 10))

pie(x, 
    col = topo.colors(10),
    labels = x,
    radius = 1)

pie(x,
    col = terrain.colors(10),
    labels = paste(round(100*x/sum(x), digits = 1),'%', sep = ''),
    radius = 1)

par(mfrow = c(1,1))
mtext(side = 1, 
      'hey hey hey hey hey', 
      line = 2.1)"),
              
   actionButton("pieeval", h2("Evaluate"), width = '100%')),
        
   mainPanel(plotOutput("piechart", height = "550px")))),

tabPanel(h4("Box Plots"),
   sidebarLayout( 
      sidebarPanel(
         shinyAce::aceEditor("boxcode", 
                             mode = "r", 
                             theme = "github", 
                             height = "475px",
                             value = 
"set.seed(NULL)

data<-replicate(8,
sample(1:50,size = 10))
boxplot(data, 
col = cm.colors(8),
xlab = 'Sample',
las = 1)"),

   actionButton("boxeval", h2("Evaluate"), width = '100%')),
        
   mainPanel(plotOutput("boxplot", height = "550px")))),

tabPanel(h4("Trellis Plots"),
   sidebarLayout(
      sidebarPanel(
         checkboxGroupInput("mtcars", 
                            label = h4("mtcars Columns Plotted"), 
                            choices = names(mtcars), 
                            selected = "mpg")),
      mainPanel(plotOutput("trellis", height = "550px"))))),
  
server = function(input, output, session) {
  
  output$barplot <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$bareval
      return(isolate(eval(parse(text=input$barcode))))
})
  output$piechart <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$pie
      return(isolate(eval(parse(text=input$piecode))))
})
  output$boxplot <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$boxeval
      return(isolate(eval(parse(text=input$boxcode))))
})
output$trellis <- renderPlot({
    plot(mtcars[,c(input$mtcars)], col = rainbow(length(input$mtcars)), 
         pch = 16, cex = 1+length(input$mtcars)*.1)
})
})
}
