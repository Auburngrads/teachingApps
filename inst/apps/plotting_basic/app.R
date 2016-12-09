library(teachingApps)

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Plotting Basics',
                theme = shinythemes::shinytheme(theme = getShinyOptions("theme")),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(getShinyOptions("appName"))),
                
tabPanel(h4("shinyAce"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "plots", 
                          mode = "r", 
                          theme = "github", 
                          height = "475px",
                          value = 
"par(oma = c(0,0,0,0), mar = c(4,4,2,2))

set.seed(4)

x<-sort(sample(1:50,size = 10))
y<-sort(sample(1:50,size = 10))

plot(x, y,
     xlab = 'X-axis label (Side 1)',
     ylab = 'Y-axis label (Side 2)',
     main = 'Plot Title (Side 3)',
     sub = 'Subtitle or Caption',
     col.axis = 1,
     col.lab = 1,
     axes = TRUE,
     type = 'p',
     las = 0)"),
     
     actionButton("evalplots", h2("Evaluate"), width = '100%')),
        
  mainPanel(plotOutput("plots", height = "550px"), width = 7))),

tabPanel(h4("Plot Type"), 
         titlePanel("The default is type = 'p'"),
 sidebarLayout( 
        sidebarPanel(
            radioButtons("types", 
                         label = h4(HTML("<b><u>PLOT TYPE</u> <red>type =</red></b>")), 
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
        
          mainPanel( plotOutput("plottypes", height = "550px")))),
                
tabPanel(h4("Enlarge Text"), 
         titlePanel("Several cex arguments exist...the default for each is 1"),
sidebarLayout(
  sidebarPanel(
    sliderInput("cex", 
                label = h4(HTML("<b><u>OBJECTS</u><red> cex =</red></b>")),
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE),
    sliderInput("cex.axis",
                label = h4(HTML("<b><u>AXES</u><red> cex.axis =</red></b>")),  
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE),
    sliderInput("cex.lab",
                label = h4(HTML("<b><u>LABELS</u><red>cex.lab =</red></b>")), 
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE),
    sliderInput("cex.main", 
                label = h4(HTML("<b><u>TITLES</u><red> cex.main =</red></b>")), 
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE)),
  
  mainPanel(plotOutput("cexplot",height = "550px")))),

tabPanel(h4("Enlarge Objects"), 
         titlePanel("These arguments change how plotted objects are displayed"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("pch",
                  label = h4(HTML("<b><u>PLOT CHARACTER</u><red> pch =</red></b>")),  
                  min = 0,
                  max = 20,
                  value = 1, 
                  step =   1, 
                  animate = TRUE),
      sliderInput("col", 
                  label = h4(HTML("<b><u>COLOR</u> <red> col =</red></b>")),
                  min = 0, 
                  max = 20, 
                  value = 1, 
                  step =   1, 
                  animate = TRUE),
      sliderInput("lty", 
                  label = h4(HTML("<b><u>LINE TYPE</u> <red>lty =</red></b>")),
                  min = 0, 
                  max = 20, 
                  value = 1, 
                  step =   1, 
                  animate = TRUE),
      sliderInput("lwd", 
                  label = h4(HTML("<b><u>LINE WEIGHT</u> <red>lwd =</red></b>")),
                  min = 0, 
                  max =  3, 
                  value = 1, 
                  step = 0.5, 
                  animate = TRUE)),
  
  mainPanel( plotOutput("objectplot",height = "550px")))),

tabPanel(h4("Plot Annotations"),
  sidebarLayout( 
    sidebarPanel(
      radioButtons("ann",
                   label = h4(HTML("Display Annotations <b><red> ann = </red></b>")), 
                   choices = c("TRUE", "FALSE"), 
                   selected = "TRUE"),
      radioButtons("axes", 
                   label = h4(HTML("Display Axes <b><red> axes = </red></b>")), 
                   choices = c("TRUE", "FALSE"), 
                   selected = "TRUE"),
      radioButtons("xaxt", 
                   label = h4(HTML("Display x-axis <b><red> xaxt = </red></b>")), 
                   choices = c("Show 's'", "No Show 'n'"), 
                   selected = "Show 's'"),
      radioButtons("yaxt", 
                   label = h4(HTML("Display y-axis <b><red>yaxt = </red></b>")), 
                   choices = c("Show 's'", "No Show 'n'"), 
                   selected = "Show 's'")),
    
    mainPanel(plotOutput("axis", height = "550px"))))),

server = function(input, output, session) {
  
  output$plots <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
  output$plottypes = renderPlot({
      par(mar = c(5,4,2,2))
      set.seed(4)
      x<-sort(sample(1:50,size = 10))
      y<-sort(sample(1:50,size = 10))
      plot(x, y, 
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
      plot(x = 1:15,y = 1:15,
           xlab = "Side 1", 
           ylab = "Side 2", 
           main = "Title",
           cex = input$cex, cex.axis = input$cex.axis, 
           cex.lab = input$cex.lab, cex.main = input$cex.main)
      box(lwd = 2)
})
  output$objectplot <- renderPlot({
      plot(x = 1:15,y = 1:15,
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
    par(oma = c(0,0,0,0), mar = c(5,4,2,2))
    plot(x = 1:15,y = 1:15,
         xlab = "Side 1",
         ylab = "Side 2",
         main = "Title",
         ann = input$ann, 
         axes = input$axes, 
         xaxt = switch(input$xaxt, 
                       "Show 's'" = "s", 
                       "No Show 'n'" = "n"), 
         yaxt = switch(input$yaxt, 
                       "Show 's'" = "s", 
                       "No Show 'n'" = "n"))
})  
})
