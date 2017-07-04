ui = navbarPage(title = 'Distribution Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = add_logo(),


tabPanel('Properties',
         mainPanel(uiOutput('cdfdemo', class = 'ta-text'), width = 12)),

tabPanel('Computing Values in R',
         mainPanel(uiOutput('cdfr', class = 'ta-text'), width = 12)),
                                
 tabPanel('Shiny App',
  sidebarLayout( 
    sidebarPanel(width = 5,
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

        actionButton("evalcdf", "Evaluate", width = '100%')),
        
        mainPanel(plotOutput("plotcdf", height = "600px"), width = 7))))
