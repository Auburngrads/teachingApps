ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),

sidebarLayout(
  sidebarPanel(width = 5,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "regplot", 
                        mode = "r", 
                        theme = "github", 
                        height = "475px",
                        value = 
"par(mfrow = c(2,2), # Arrange plots in a 2x2 array 
family = 'serif', # Change the font family
mar = c(2.5,4.1,1.5,2.1)) # Change the plot margins

plot(lm(mtcars), which  = 1, las = 1)
plot(lm(mtcars), which  = 2, las = 1)
plot(lm(mtcars), which  = 3, las = 1)
plot(lm(mtcars), which  = 4, las = 1)

par(mfrow = c(1,1)) # Return plot window to a 1x1 array"),

    actionButton("evalreg", "Evaluate")),
        
    mainPanel(plotOutput("plotreg", height = "550px"), width = 7)))
