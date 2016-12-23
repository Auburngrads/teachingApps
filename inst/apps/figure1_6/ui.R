library(shiny)
  
ui = navbarPage(title = 'Figure 1.6',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption('theme')),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption('appName'))),

tabPanel(h4("Data Set"), DT::dataTableOutput("heatexchanger", height = "575px")),
                
tabPanel(h4("Figure 1.6"), titlePanel("Edit this code and press 'Evaluate' to change the figure"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig6plot", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2, mar = c(0,0,0,0))
plot(NA, axes = FALSE, xlab = '', ylab = '',
     xlim = range(-50,350),
     ylim = range(-10,300))

segments( x0 = c(0,0,0,0,0,rep(0,5),rep(100,5),rep(200,5),100,200,300),
          y0 = c(0,100,200,300,0,seq(232,280,12),seq(132,180,12),seq(32,80,12),0,0,0),
          x1 = c(350,350,350,350,0,rep(300,15),100,200,300),
          y1 = c(0,100,200,300,300,seq(232,280,12),seq(132,180,12),seq(32,80,12),300,300,300),
          lwd = c(rep(2,5), rep(1,18)))

text(x = rep(-25,3),
     y = seq(56,256,100),
     c('Plant 3','Plant 2','Plant 1'),
     cex = rep(0.9,3))

text(x = c(50,rep(150,2),rep(250,3)),
     y = c(rep(290,2),190,290,190,90),
     c('1 failure','2 failures','2 failures','2 failures','3 failures','1 failure'),
     cex = rep(0.8,6))

text(x = seq(50,250,100),
     y = rep(-8,3),
     c('1981','1982','1983'),
     cex = rep(0.9,3))

text(x = rep(310,3),
     y = seq(56,256,100),
     c('95','95','99'),
     cex = rep(0.9,3))

segments(x0 = rep(320,3),
         y0 = seq(56,256,100),
         x1 = rep(345,3),
         y1 = seq(56,256,100),
         lty=rep(2,3))

arrows(x0 = rep(295,15),
       y0 = c(seq(232,280,12),seq(132,180,12),seq(32,80,12)),
       rep(300,15),
       length=rep(0.1,15))

arrows(x0 = rep(345,3),
       y0 = seq(56,256,100),
       x1 = rep(350,3),
       length=rep(0.1,3))"),
              actionButton("evalfig6", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig6", height = "600px"), width = 7))),
                
tabPanel(h4("Figure 1.7"), titlePanel("Edit this code and press 'Evaluate' to change the figure"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig7plot", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2,mar = c(0,0,0,0))
plot(NA,axes = FALSE,xlab = '',ylab = '',
     xlim = range(-50,350),
     ylim = range(-10,300))

segments( x0 = c(0,0,0,0,0,rep(0,15),100,200,300),
          y0 = c(0,100,200,300,0,seq(232,280,12),seq(132,180,12),seq(32,80,12),0,0,0),
          x1 = c(350,350,350,350,0,rep(300,5),rep(200,5),rep(100,5),100,200,300),
          y1 = c(0,100,200,300,300,seq(232,280,12),seq(132,180,12),seq(32,80,12),300,300,300),
          lwd=c(rep(2,5),rep(1,18)))

text(x = rep(-25,3),
     y = seq(56,256,100),
     c('Plant 3','Plant 2','Plant 1'),
     cex=rep(0.9,3))

text(x = c(rep(50,3),rep(150,2),250),
     y = c(90,190,290,190,rep(290,2)),
     c('1 failure','2 failures','2 failures','2 failures','3 failures','1 failure'),
     cex = rep(0.8,6))

text(x = seq(50,250,100),
     y = rep(-8,3),
     c('1981','1982','1983'),
     cex = rep(0.9,3))

text(x = c(110,210,310),
     y = seq(56,256,100),
     c('95','95','99'),
     cex = rep(0.9,3))

segments(x0 = c(120,220,320),
         y0 = seq(56,256,100),
         x1 = c(345,345,345),
         y1 = seq(56,256,100),
         lty=rep(2,3))

arrows(x0 = c(rep(295,5),rep(195,5),rep(95,5)),
       y0 = c(seq(232,280,12),seq(132,180,12),seq(32,80,12)),
       x1 = c(rep(300,5),rep(200,5),rep(100,5)),
       length=rep(0.1,15))

arrows(x0 = rep(345,3),
       y0 = seq(56,256,100),
       x1 = rep(350,3),
       length=rep(0.1,3))"),
              actionButton("evalfig7", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig7", height = "600px"), width = 7))))
