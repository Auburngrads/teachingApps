ui = navbarPage(title = 'Survival Function',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel('Properties',
         uiOutput('survdemo', class = 'ta-text')),

tabPanel('Computing Values in R',
         uiOutput('survr', class = 'ta-text')),
                
tabPanel('ShinyApp',                
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "relplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(
expr = 1-pnorm(x, mean = 3, sd = 1),
xlab = 'Time, t',
ylab = expression(S(t)[Normal]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 3,
col = 4,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),

        actionButton("evalrel", "Evaluate")),
        
        mainPanel(plotOutput("plotrel", height = "600px")))))
