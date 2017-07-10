ui = navbarPage(title = 'Global Plot Parameters',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel("Plot Device Margins", 
         titlePanel("Changing the inner margin requires four terms - mar = c(5,4,4,2)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("mar1", 
                  label = HTML("<u>SIDE 1</u>   <red>mar = c(x , , ,)</red> </b>"), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE),
      sliderInput("mar2",
                  label = HTML("<u>SIDE 2</u>   <red>mar = c(, x , ,)</red> </b>"), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE),
      sliderInput("mar3",
                  label = HTML("<u>SIDE 3</u>    <red>mar = c(, , x ,)</red> </b>"), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE),
      sliderInput("mar4", 
                  label = HTML("<u>SIDE 4</u>   <red>mar =c(, , , x)</red> </b>"), 
                  min = 0, 
                  max = 5, 
                  value = 0, 
                  step = 0.5, 
                  animate = TRUE)),
  
  mainPanel( plotOutput("marplot",height = "550px")))),
  
tabPanel("Plot Window Margins", 
         titlePanel("Changing the outer margin requires four terms - oma = c(0,0,0,0)"),
  sidebarLayout(
        sidebarPanel(
            sliderInput("oma1", 
                        label = HTML("<u>SIDE 1</u><red>oma = c(x , , ,)</red> "), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE),
            sliderInput("oma2",
                        label = HTML("<u>SIDE 2</u><red>oma = c(, x , ,)</red>"), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE),
            sliderInput("oma3",
                        label = HTML("<u>SIDE 3</u><red>oma = c(, , x ,)</red>"), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE),
            sliderInput("oma4", 
                        label = HTML("<u>SIDE 4</u><red>oma =c(, , , x)</red>"), 
                        min = 0, 
                        max = 5, 
                        value = 0, 
                        step = 0.5, 
                        animate = TRUE)),
  
  mainPanel( plotOutput("omaplot",height = "550px")))),
                  

tabPanel("Multiple Curves", 
   sidebarLayout( 
      sidebarPanel(width = 5,
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "curvescode", 
                            mode = "r", 
                            theme = "github", 
                            value = 
"set.seed(NULL)

x1<-sort(sample(1:50,size = 10))
y1<-sort(sample(1:50,size = 10))
x2<-sort(sample(1:50,size = 10))
y2<-sort(sample(1:50,size = 10))

plot(x1,y1,pch = 16, col = 2)

points(x2,y2,pch = 16, col = 4)"),
      
  actionButton("curveseval", "Evaluate")),
        
  mainPanel(plotOutput("curves", height = "550px"), width = 7))),
    
tabPanel("Multiple Plots",
   sidebarLayout( 
      sidebarPanel(width = 5,
         shinyAce::aceEditor(fontSize = 16, 
                             wordWrap = T,
                             outputId = "plotscode", 
                             mode = "r", 
                             theme = "github", 
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

  actionButton("plotseval", "Evaluate")),
        
  mainPanel(plotOutput("plots", height = "550px"), width = 7))))
