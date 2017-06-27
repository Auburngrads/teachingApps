library(shiny)
  
ui = navbarPage(title = 'Figure 1.1',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_style(),
                footer = teachingApps::add_brand(),


tabPanel(h4("Data Set"), DT::dataTableOutput("lzbearing", height = "600px")),
                
tabPanel(h4("Figure 1.1"),titlePanel("Edit this code and press 'Evaluate' to change the figure"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig1plot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "library(SMRD)
par(family='serif', font=2)
hist(lzbearing$megacycles,
     breaks=seq(0,200,20),
     col='black',
     border='white',
     prob=TRUE,
     main='Figure 1.1 - Histogram of the ball bearing failure data',
     las = 1)"),
              actionButton("evalfig1", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig1", height = "600px"), width = 7))),

tabPanel(h4("Figure 1.2"),titlePanel("Edit this code and press 'Evaluate' to change the figure"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig2plot", 
                          mode = "r", 
                          theme = "github",
                          height = "450px", 
                          fontSize = 15,
                          value = "
library(SMRD)
par(family='serif', font=2)

lzbearing.ld <- frame.to.ld(lzbearing, 
                            response.column = 1, 
                            time.units = 'Megacycles')

event.plot(lzbearing.ld)"),
      
        actionButton("evalfig2", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig2", height = "600px"), width = 7))))

