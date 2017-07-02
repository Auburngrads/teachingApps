ui = navbarPage(title = 'Probability Functions',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_stamp(),


tabPanel(h4('Overview'),
         mainPanel(uiOutput('overview'), 
                   class = 'shiny-text-output', 
                   width = 12)),

tabPanel(h4('Relationship Table'),
         mainPanel(uiOutput('functable'), 
                   class = 'shiny-text-output', 
                   width = 12)),
                
navbarMenu(h4('The Functions'), icon = icon('folder-open'),
           
tabPanel(h4('Cumulative Distribution Function'), 
tabsetPanel(type = 'pills',
                                
  tabPanel(h4('Properties of the CDF'),
           mainPanel(uiOutput('cdfdemo'), 
                     class = 'shiny-text-output', 
                     width = 12)),

  tabPanel(h4('Computing CDF Values in R'),
           mainPanel(uiOutput('cdfr'), 
                     class = 'shiny-text-output', 
                     width = 12)),
                                
  tabPanel(h4('Interactive CDF Shiny App'),
    sidebarLayout( 
      sidebarPanel(width = 4,
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "cdfplot", 
                            mode = "r", 
                            theme = "github", 
                            height = "450px", 
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

        actionButton("evalcdf", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotcdf", height = "600px"), width = 8))))),

tabPanel(h4('Probability Density Function'), 
        tabsetPanel(type = 'pills',

  tabPanel(h4('Properties'),
           mainPanel(uiOutput('pdfdemo'), 
                     class = 'shiny-text-output', 
                     width = 12)),

  tabPanel(h4('Computing Values in R'),
           mainPanel(uiOutput('pdfr'), 
                     class = 'shiny-text-output', 
                     width = 12)),
                    
  tabPanel(h4('Shiny App'),
    sidebarLayout(
      sidebarPanel(
        shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "pdfplot", 
                            mode = "r", 
                            theme = "github", 
                            height = "450px", 
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

        actionButton("evalpdf", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotpdf", height = "600px"))))))))
