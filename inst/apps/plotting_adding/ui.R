ui = navbarPage(title = 'Adding Objects To Plots',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("Add Text",
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "textcode", 
                                mode = "r", 
                                theme = "github", 
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

    actionButton("texteval", "Evaluate")),
        
    mainPanel(plotOutput("text", height = "550px"), width = 7))),

tabPanel("Add Equations",
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "eqncode", 
                                mode = "r", 
                                theme = "github",
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

   actionButton("eqneval", "Evaluate")),
        
   mainPanel(plotOutput("eqn"), width = 7))),

tabPanel("Add Points",
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "ptcode", 
                                mode = "r", 
                                theme = "github", 
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
       
 actionButton("pteval", "Evaluate")),
        
 mainPanel(plotOutput("point", height = "550px"), width = 7))),

tabPanel("Add Lines",
   sidebarLayout( 
      sidebarPanel(htmlOutput('lineace'),
                   htmlOutput('lineact')),
        
  mainPanel(
    tabsetPanel(id = 'lines',
       tabPanel("Add Lines 1", value = 'lines1',
          plotOutput('abline0', height = '550px')),
       tabPanel('Add Lines 2', value = 'lines2',
          plotOutput('abline1', height = '550px')),
       tabPanel('Add Lines 3', value = 'lines3',
          plotOutput('abline2', height = '550px')))))),

tabPanel("Add A Grid",
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "gridcode", 
                                mode = "r", 
                                theme = "github", 
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
       
  actionButton("grideval", "Evaluate")),
        
  mainPanel(plotOutput("grid", height = "550px"), width = 7))),

tabPanel("Add A Legend",
      sidebarLayout( 
        sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "legcode", 
                                mode = "r", 
                                theme = "github", 
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

  actionButton("legeval", "Evaluate")),
        
  mainPanel(plotOutput("legend", height = "550px"), width = 7))))
