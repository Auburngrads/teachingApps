ui = navbarPage(title = 'Plotting Basics',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("shinyAce",
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "plots", 
                          mode = "r", 
                          theme = "github", 
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
     
     actionButton("evalplots", "Evaluate")),
        
  mainPanel(plotOutput("plots", height = "550px"), width = 7))),

tabPanel("Plot Type", 
         titlePanel("The default is type = 'p'"),
 sidebarLayout( 
        sidebarPanel(
            radioButtons("types", 
                         label = HTML("<u>PLOT TYPE</u> <red>type =</red>"), 
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
                
tabPanel("Enlarge Text", 
         titlePanel("Several cex arguments exist...the default for each is 1"),
sidebarLayout(
  sidebarPanel(
    sliderInput("cex", 
                label = HTML("<u>OBJECTS</u><red> cex =</red></b>"),
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE),
    sliderInput("cex.axis",
                label = HTML("<u>AXES</u><red> cex.axis =</red>"),  
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE),
    sliderInput("cex.lab",
                label = HTML("<u>LABELS</u><red>cex.lab =</red>"), 
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE),
    sliderInput("cex.main", 
                label =HTML("<u>TITLES</u><red> cex.main =</red>"), 
                min = 0, 
                max = 4, 
                value = 1, 
                step = 0.5, 
                animate = TRUE)),
  
  mainPanel(plotOutput("cexplot",height = "550px")))),

tabPanel("Enlarge Objects", 
         titlePanel("These arguments change how plotted objects are displayed"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("pch",
                  label = HTML("<u>PLOT CHARACTER</u><red> pch =</red>"),  
                  min = 0,
                  max = 20,
                  value = 1, 
                  step =   1, 
                  animate = TRUE),
      sliderInput("col", 
                  label = HTML("<u>COLOR</u> <red> col =</red></b>"),
                  min = 0, 
                  max = 20, 
                  value = 1, 
                  step =   1, 
                  animate = TRUE),
      sliderInput("lty", 
                  label = HTML("<u>LINE TYPE</u> <red>lty =</red></b>"),
                  min = 0, 
                  max = 20, 
                  value = 1, 
                  step =   1, 
                  animate = TRUE),
      sliderInput("lwd", 
                  label = HTML("<u>LINE WEIGHT</u> <red>lwd =</red></b>"),
                  min = 0, 
                  max =  3, 
                  value = 1, 
                  step = 0.5, 
                  animate = TRUE)),
  
  mainPanel( plotOutput("objectplot",height = "550px")))),

tabPanel("Plot Annotations",
  sidebarLayout( 
    sidebarPanel(
      radioButtons("ann",
                   label = HTML("Display Annotations <b><red> ann = </red>"), 
                   choices = c("TRUE", "FALSE"), 
                   selected = "TRUE"),
      radioButtons("axes", 
                   label = HTML("Display Axes <b><red> axes = </red>"), 
                   choices = c("TRUE", "FALSE"), 
                   selected = "TRUE"),
      radioButtons("xaxt", 
                   label = HTML("Display x-axis <b><red> xaxt = </red>"), 
                   choices = c("Show 's'", "No Show 'n'"), 
                   selected = "Show 's'"),
      radioButtons("yaxt", 
                   label = HTML("Display y-axis <b><red>yaxt = </red>"), 
                   choices = c("Show 's'", "No Show 'n'"), 
                   selected = "Show 's'")),
    
    mainPanel(plotOutput("axis", height = "550px")))))
