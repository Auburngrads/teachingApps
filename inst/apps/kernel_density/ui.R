ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "code", 
                        mode = "r", 
                        theme = "github", 
                        value = 
"library(scales)

beta <- 2
theta <- 15

w <- rweibull(100,
              shape = beta, 
              scale = theta)

plot(density(w),
     lwd = 1,
     xlab = '', 
     main = '')

curve(dweibull(x,
               shape = beta, 
               scale = theta), 
               add = TRUE,
               lwd = 2,
               col = 2)
axis(side = 1, at = w, labels = F)

polygon(density(w)$x,
        density(w)$y,
        col = alpha('lightblue',0.5))"),

          actionButton("eval", "Evaluate")),
        
          mainPanel(plotOutput("output", height = '600px'), width = 7)))
