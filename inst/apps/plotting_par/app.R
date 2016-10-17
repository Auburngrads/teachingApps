



shinyApp(options = list(height = "800px"),
         
  ui = navbarPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                  try(includeCSS(system.file('css',
                                             'my-shiny.css', 
                                             package = 'teachingApps')), silent = T),

tabPanel(h4("Plot Device Margins"), 
         titlePanel("Changing the inner margin requires four terms - mar = c(5,4,4,2)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("mar1", 
                  label = h4(HTML("<b><u>SIDE 1</u>   <red>mar = c(x , , ,)</red> </b>")), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE),
      sliderInput("mar2",
                  label = h4(HTML("<b><u>SIDE 2</u>   <red>mar = c(, x , ,)</red> </b>")), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE),
      sliderInput("mar3",
                  label = h4(HTML("<b><u>SIDE 3</u>    <red>mar = c(, , x ,)</red> </b>")), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE),
      sliderInput("mar4", 
                  label = h4(HTML("<b><u>SIDE 4</u>   <red>mar =c(, , , x)</red> </b>")), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE)),
  
  mainPanel( plotOutput("marplot",height = "550px")))),
  
tabPanel(h4("Plot Window Margins"), 
         titlePanel("Changing the outer margin requires four terms - oma = c(0,0,0,0)"),
  sidebarLayout(
        sidebarPanel(
            sliderInput("oma1", 
                        label = h4(HTML("<b><u>SIDE 1</u><red>oma = c(x , , ,)</red> </b>")), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE),
            sliderInput("oma2",
                        label = h4(HTML("<b><u>SIDE 2</u><red>oma = c(, x , ,)</red> </b>")), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE),
            sliderInput("oma3",
                        label = h4(HTML("<b><u>SIDE 3</u><red>oma = c(, , x ,)</red> </b>")), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE),
            sliderInput("oma4", 
                        label = h4(HTML("<b><u>SIDE 4</u><red>oma =c(, , , x)</red> </b>")), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE)),
  
  mainPanel( plotOutput("omaplot",height = "550px")))),
                  

tabPanel(h4("Multiple Curves"), 
   sidebarLayout( 
      sidebarPanel(width = 5,
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "curvescode", 
                            mode = "r", 
                            theme = "github", 
                            height = "475px",
                            value = 
"set.seed(NULL)

x1<-sort(sample(1:50,size = 10))
y1<-sort(sample(1:50,size = 10))
x2<-sort(sample(1:50,size = 10))
y2<-sort(sample(1:50,size = 10))

plot(x1,y1,pch = 16, col = 2)

points(x2,y2,pch = 16, col = 4)"),
      
  actionButton("curveseval", h2("Evaluate"), width = '100%')),
        
  mainPanel(plotOutput("curves", height = "550px"), width = 7))),
    
tabPanel(h4("Multiple Plots"),
   sidebarLayout( 
      sidebarPanel(width = 5,
         shinyAce::aceEditor(fontSize = 16, 
                             wordWrap = T,
                             outputId = "plotscode", 
                             mode = "r", 
                             theme = "github", 
                             height = "475px",
                             value = 
"par(mfrow = c(1,1))

x1<-sort(sample(1:50,size = 10))
y1<-sort(sample(1:50,size = 10))
x2<-sort(sample(1:50,size = 10))
y2<-sort(sample(1:50,size = 10))

plot(x1,y1,pch = 16, col = 2)
par(new = FALSE)
plot(x2,y2,pch = 16, col = 4)

par(mfrow = c(1,1))"),

  actionButton("plotseval", h2("Evaluate"), width = '100%')),
        
  mainPanel(plotOutput("plots", height = "550px"), width = 7))),
  
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})

output$marplot <- renderPlot({
      par(mar = c(input$mar1, input$mar2, input$mar3, input$mar4), xpd = TRUE)
      plot(1:10,1:10,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title",
           xlim = c(1,7), 
           ylim = c(1,7), 
           type = "l")
      text(1,3.5, 
           labels = "mar( ) RESIZES THE PLOT AREA WITHIN THE PLOT WINDOW - THE 'INNER BOX'", 
           cex = 1.5, 
           adj = 0)
      box(lwd = 2)
})
  output$omaplot <- renderPlot({
      par(oma = c(input$oma1, input$oma2, input$oma3, input$oma4), xpd = TRUE)
      plot(1:10,1:10,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title", 
           xlim = c(1,7), 
           ylim = c(1,7), 
           type = "l")
      text(1,3.5, "oma( ) RESIZES THE ENTIRE PLOT WINDOW - THE 'OUTER BOX'", 
           cex = 1.5, 
           adj = 0)
      box(lwd = 2)
})
  output$curves <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$curveseval
      return(isolate(eval(parse(text=input$curvescode))))
})
  output$plots <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4.5,4,2,2))
      input$plotseval
      return(isolate(eval(parse(text=input$plotscode))))
})
})
