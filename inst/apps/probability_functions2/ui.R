ui = navbarPage(title = 'Probability Functions',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),


tabPanel('Overview',
         uiOutput('overview', class = 'ta-text')),

tabPanel('Relationship Table',
         uiOutput('functable', class = 'ta-text')),
                
navbarMenu('The Functions', icon = icon('folder-open'),
           
tabPanel('Cumulative Distribution Function', 
tabsetPanel(type = 'pills',
                                
  tabPanel('Properties of the CDF',
           uiOutput('cdfdemo', class = 'ta-text')),

  tabPanel('Computing CDF Values in R',
           uiOutput('cdfr', class = 'ta-text')),
                                
  tabPanel('Interactive CDF Shiny App',
    sidebarLayout( 
      sidebarPanel(width = 4,
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "cdfplot", 
                            mode = "r", 
                            theme = "github", 
                            value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(
pweibull(x,shape = 1.7, scale = 1),
xlab = 'Time, t',
ylab = expression(F(t)[Weibull]),
ylim = c(0,1),
xlim = c(0,3),
lwd = 3,
lty = 1,
col = 2,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),

        actionButton("evalcdf", "Evaluate")),
        
        mainPanel(plotOutput("plotcdf", height = "600px"), width = 8))))),

tabPanel('Probability Density Function', 
        tabsetPanel(type = 'pills',

  tabPanel('Properties',
           uiOutput('pdfdemo', class = 'ta-text')),

  tabPanel('Computing Values in R',
           uiOutput('pdfr', class = 'ta-text')),
                    
  tabPanel('Shiny App',
    sidebarLayout(
      sidebarPanel(
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "pdfplot", 
                            mode = "r", 
                            theme = "github", 
                            value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(dexp(x,rate = 1.7),
      xlab = 'Time, t',
      ylab = expression(f(t)[Exponential]),
      xlim = c(0,3),
      lwd = 3,
      lty = 2,
      col = 3,
      cex.lab = 1.5,
      cex.axis = 1.5,
      las = 1)"),

        actionButton("evalpdf", "Evaluate")),
        
        mainPanel(plotOutput("plotpdf", height = "600px"))))))))
