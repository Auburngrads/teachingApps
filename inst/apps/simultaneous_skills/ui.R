ui = navbarPage(title = 'R Plotting',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("shinyAce",
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "plots", 
                          mode = "r", 
                          theme = "github", 
                          height = "475px",
                          value = 
"par(family = 'serif', font = 2)

x<-seq(0,2.4,by = .01)
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

        actionButton("evalplots", "Evaluate")),
        
        mainPanel(plotOutput("plots", height = "600px")))),

tabPanel("Plot Type",
 sidebarLayout( 
    sidebarPanel(width = 3,
       radioButtons("types", 
                    label = HTML("<u>Plot Type</u>   <red>type =</red>"), 
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
                
tabPanel("Enlarge Text",
  sidebarLayout(
     sidebarPanel(width = 3,
        sliderInput("cex", 
                    label = HTML("<u>Objects</u>   <red>cex =</red>"),
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE),
        sliderInput("cex.axis",
                    label = HTML("<u>Axes</u>   <red>cex.axis =</red>"),  
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE),
        sliderInput("cex.lab",
                    label = HTML("<u>Labels</u>   <red>cex.lab =</red>"), 
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE),
        sliderInput("cex.main", 
                    label = HTML("<u>Titles</u>   <red>cex.main =</red>"), 
                    min = 0, 
                    max = 4, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE)),
     
     mainPanel( plotOutput("cexplot",height = "600px"), width = 9))),

tabPanel("Enlarge Objects",
  sidebarLayout(
     sidebarPanel(width = 3,
        sliderInput("pch",
                    label = HTML("<u>Plot Character</u> <red>pch =</red>"),  
                    min = 0, 
                    max = 20, 
                    value = 1, 
                    step =   1, 
                    animate = TRUE),
        sliderInput("col", 
                    label = HTML("<u>Color</u> <red>col =</red>"),
                    min = 0, 
                    max = 20, 
                    value = 1, 
                    step =   1, 
                    animate = TRUE),
        sliderInput("lty", 
                    label = HTML("<u>Line Type</u> <red>lty =</red>"),
                    min = 0, 
                    max = 20, 
                    value = 1, 
                    step =   1, 
                    animate = TRUE),
        sliderInput("lwd", 
                    label = HTML("<u>Line Weight</u> <red>lwd =</red>"),
                    min = 0, 
                    max =  3, 
                    value = 1, 
                    step = 0.5, 
                    animate = TRUE)),
  
     mainPanel( plotOutput("objectplot",height = "600px"), width = 9))),

tabPanel("Plot Annotations",
   sidebarLayout( 
      sidebarPanel(width = 3,
         radioButtons("ann", 
                      label = HTML("Annotations <red>ann = </red>"), 
                      choices = c("TRUE", 
                                  "FALSE"), 
                      selected = "TRUE"),
         radioButtons("axes", 
                      label = HTML("Display Axes <red>axes = </red>"), 
                      choices = c("TRUE", 
                                  "FALSE"), 
                      selected = "TRUE"),
         radioButtons("xaxt", 
                      label = HTML("Display x-axis <red>xaxt = </red>"), 
                      choices = c("Show 's'", 
                                  "No Show 'n'"), 
                      selected = "Show 's'"),
         radioButtons("yaxt", 
                      label = HTML("Display y-axis <red>yaxt = </red>"), 
                      choices = c("Show 's'", 
                                  "No Show 'n'"), 
                      selected = "Show 's'")),
    
      mainPanel(plotOutput("axis", height = "600px"), width = 9))))
