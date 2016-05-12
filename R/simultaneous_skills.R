simultaneous_skills <-
function(...) {

  if(!isNamespaceLoaded('shiny'))  attachNamespace('shiny')
  
shinyApp(options = list(width = "100%", height = "800px"),
         
ui = navbarPage(theme = shinythemes::shinytheme("flatly"),
                try(includeCSS('css/my-shiny.css'), silent = TRUE),
tabPanel(h4("shinyAce"),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("plots", 
                          mode = "r", 
                          theme = "github", 
                          height = "475px",
                          value = 
"par(family='serif', font=2)

x<-seq(0,2.4,by=.01)
y<-dweibull(seq(0,2.4,by=.01),shape=1.7,scale=1)

plot(x = x, 
     y = y, 
     type = 'l', 
     lwd = 1.25, 
     xlab = 't', 
     ylab = 'f(t)', 
     las = 1,
     sub = 'Figure 2.6 - Likelihood contributions for different kids of censoring')\n
polygon(c(seq(0,0.5,.01),0.5),\nc(  dweibull(seq(0,0.5,.01),shape = 1.7,scale = 1),0)\n, col = 1)\n
polygon(c(1,seq(1,1.5,.01),1.5),\nc(0,dweibull(seq(1,1.5,.01),shape = 1.7,scale = 1),0)\n, col = 1)\n
polygon(c(2,seq(2,2.4,.01),2.4),\nc(0,dweibull(seq(2,2.4,.01),shape = 1.7,scale = 1),0)\n, col = 1)\n\n
text(.16,.75,'Left Censoring')
text(1.3,.65,'Interval Censoring')
text(2.2,.15,'Right Censoring')
box(lwd=1.25)"),

        actionButton("evalplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plots", height = "600px")))),

tabPanel(h4("Plot Type"),
 sidebarLayout( 
    sidebarPanel(width = 3,
       radioButtons("types", 
                    label = h2(HTML("<u>Plot Type</u>   <red>type =</red>")), 
                    choices = c("'p' (Points)", 
                                "'l' (Line)", 
                                "'b' (Both)", 
                                "'c' (Cutout)", 
                                "'o' (Overplotted)", 
                                "'h' (Histogram)", 
                                "'s' (Step1)", 
                                "'S' (Step2)", 
                                "'n' (No Plot)" ), 
                    selected = "'p' (Points)" )),
        
          mainPanel( plotOutput("plottypes", height = "600px"), width = 9))),
                
tabPanel(h4("Enlarge Text"),
  sidebarLayout(
     sidebarPanel(width = 3,
        sliderInput("cex", 
                    label = h2(HTML("<u>Objects</u>   <red>cex =</red>")),
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE),
        sliderInput("cex.axis",
                    label = h2(HTML("<u>Axes</u>   <red>cex.axis =</red></b>")),  
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE),
        sliderInput("cex.lab",
                    label = h2(HTML("<b><u>Labels</u>   <red>cex.lab =</red></b>")), 
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE),
        sliderInput("cex.main", 
                    label = h2(HTML("<u>Titles</u>   <red>cex.main =</red>")), 
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE)),
     
     mainPanel( plotOutput("cexplot",height = "600px"), width = 9))),

tabPanel(h4("Enlarge Objects"),
  sidebarLayout(
     sidebarPanel(width = 3,
        sliderInput("pch",
                    label = h2(HTML("<u>Plot Character</u> <red>pch =</red>")),  
                    min = 0, 
                    max = 20, 
                    value = 1, 
                    step =   1, 
                    animate = TRUE),
        sliderInput("col", 
                    label = h2(HTML("<u>Color</u> <red>col =</red>")),
                    min = 0, 
                    max = 20, 
                    value = 1, 
                    step =   1, 
                    animate = TRUE),
        sliderInput("lty", 
                    label = h2(HTML("<u>Line Type</u> <red>lty =</red>")),
                    min = 0, 
                    max = 20, 
                    value = 1, 
                    step =   1, 
                    animate = TRUE),
        sliderInput("lwd", 
                    label = h2(HTML("<u>Line Weight</u> <red>lwd =</red>")),
                    min = 0, 
                    max =  3, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE)),
  
     mainPanel( plotOutput("objectplot",height = "600px"), width = 9))),

tabPanel(h4("Plot Annotations"),
   sidebarLayout( 
      sidebarPanel(width = 3,
         radioButtons("ann", 
                      label = h2(HTML("Annotations <red>ann = </red>")), 
                      choices = c("TRUE", 
                                  "FALSE"), 
                      selected = "TRUE"),
         radioButtons("axes", 
                      label = h2(HTML("Display Axes <red>axes = </red>")), 
                      choices = c("TRUE", 
                                  "FALSE"), 
                      selected = "TRUE"),
         radioButtons("xaxt", 
                      label = h2(HTML("Display x-axis <red>xaxt = </red>")), 
                      choices = c("Show 's'", 
                                  "No Show 'n'"), 
                      selected = "Show 's'"),
         radioButtons("yaxt", 
                      label = h2(HTML("Display y-axis <red>yaxt = </red>")), 
                      choices = c("Show 's'", 
                                  "No Show 'n'"), 
                      selected = "Show 's'")),
    
      mainPanel(plotOutput("axis", height = "600px"), width = 9)))),

server = function(input, output, session) {
  
  output$plots <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
  output$plottypes = renderPlot({
      par(mar = c(4,4,2,2))
      set.seed(4)
      x<-sort(sample(1:50,size = 10))
      y<-sort(sample(1:50,size = 10))
      plot(x, y, cex = 2, lwd = 2, pch = 16,
           type = switch(input$types,
                         "'p' (Points)" = {"p"}, 
                         "'l' (Line)" = {"l"}, 
                         "'b' (Both)" = {"b"}, 
                         "'c' (Cutout)" = {"c"}, 
                         "'o' (Overplotted)" = {"o"}, 
                         "'h' (Histogram)" = {"h"}, 
                         "'s' (Step1)" = {"s"}, 
                         "'S' (Step2)" = {"S"}, 
                         "'n' (No Plot)" = {"n"} ))
})
  output$cexplot <- renderPlot({

      plot(x = 1:15,
           y = 1:15,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title",
           cex = input$cex, 
           cex.axis = input$cex.axis, 
           cex.lab = input$cex.lab, 
           cex.main = input$cex.main)
      box(lwd = 2)
})
  output$objectplot <- renderPlot({
      plot(x = 1:15,
           y = 1:15,
           xlab = "Side 1", 
           ylab = "Side 2", 
           cex = 3,
           pch = input$pch, 
           col = input$col, 
           lty = input$lty, 
           lwd = input$lwd, 
           type = "b")
      box(lwd = 2)
})
output$axis <- renderPlot({
    par(mar = c(4,4,2,2))
    plot(x = 1:15,
         y = 1:15,
         xlab = "Side 1", 
         ylab = "Side 2", 
         main = "Title", 
         ann = input$ann, 
         cex = 2,
         axes = input$axes, 
         xaxt = switch(input$xaxt, 
                       "Show 's'" = "s", 
                       "No Show 'n'" = "n"), 
         yaxt = switch(input$yaxt, 
                       "Show 's'" = "s", 
                       "No Show 'n'" = "n"))
})  
})
}
