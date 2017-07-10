ui = navbarPage(title = 'Special Plotting Functions',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("Bar Plots",
   sidebarLayout( 
      sidebarPanel(width = 5,
         shinyAce::aceEditor(fontSize = 16, 
                             wordWrap = T,
                             outputId = "barcode", 
                             mode = "r", 
                             theme = "github", 
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
       
  actionButton("bareval", "Evaluate")),
        
  mainPanel(plotOutput("barplot", height = "550px"), width = 7))),

tabPanel("Pie Charts",
   sidebarLayout( 
      sidebarPanel(width = 5,
          shinyAce::aceEditor(fontSize = 16, 
                              wordWrap = T,
                              outputId = "piecode", 
                              mode = "r", 
                              theme = "github", 
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
              
   actionButton("pieeval", "Evaluate")),
        
   mainPanel(plotOutput("piechart", height = "550px"), width = 7))),

tabPanel("Box Plots",
   sidebarLayout( 
      sidebarPanel(width = 5,
         shinyAce::aceEditor(fontSize = 16, 
                             wordWrap = T,
                             outputId = "boxcode", 
                             mode = "r", 
                             theme = "github", 
                             value = 
"set.seed(NULL)

data<-replicate(8,
sample(1:50,size = 10))
boxplot(data, 
col = cm.colors(8),
xlab = 'Sample',
las = 1)"),

   actionButton("boxeval", "Evaluate")),
        
   mainPanel(plotOutput("boxplot", height = "550px"), width = 7))),

tabPanel("Trellis Plots",
   sidebarLayout(
      sidebarPanel(
         checkboxGroupInput('mtcars',
                            label = "mtcars Columns Plotted", 
                            choices = names(datasets::mtcars), 
                            selected = "mpg")),
      mainPanel(plotOutput("trellis", height = "550px")))))
