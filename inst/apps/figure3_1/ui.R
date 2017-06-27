library(teachingApps)

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
               
sidebarLayout(
  sidebarPanel(
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "binplot", 
                        mode = "r", 
                        theme = "github", 
                        height = "450px",
                        value = 
"par(family = 'serif', font = 2)

plot(NA,
     axes = FALSE,
     xlab = '',
     ylab = '',
     xlim = range(-50,350),
     ylim = range(-10,150))

segments( x0 = c(0,0,0,100,200,300),
          y0 = c(50,100,50,20,20,20),
          x1 = c(350,350,0,100,200,300),
          y1 = c(50,100,100,100,100,100),
          lwd = c(rep(2,6)))

text(x = rep(-35,6),
     y = c(seq(27,127,50),seq(17,117,100),6),
     labels = c('Unconditional',
                'Plant 1',
                '100 tubes', 
                'Failure',
                'at start',
                'Probability'),
     cex = c(1,1.15,1,1,1,1))

text(x = c(seq(50,250,100),325),
     y = rep(20,4),
     labels = c(expression(pi[1]),
                expression(pi[2]),
                expression(pi[3]),
                expression(pi[4])),
     cex = 1.5)

text(x = seq(50,250,100),
     y = rep(108,3),
     labels = c('Year 1','Year 2','Year 3'),
     cex = rep(1.15,3))

text(x = c(150,320,320),
     y = c(rep(140,2),130),
     labels = c('Cracked tubes','Uncracked','tubes'),
     cex = rep(1,3))

text(x = c(seq(50,250,100),325),
     y = rep(77,4),
     labels = c('1','2','2','95'),
     cex = rep(1.5,4))"),

        actionButton("evalbin", h4(HTML("<b>Evaluate</b>")), width = '100%')),
        
        mainPanel(plotOutput("plotbin", height = "600px"))))
