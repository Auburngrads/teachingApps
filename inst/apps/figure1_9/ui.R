library(shiny)
  
ui = navbarPage(title = 'Figure 1.9',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption('theme')),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),

tabPanel(h4("Data Set"), DT::dataTableOutput("printedcircuitboard", height = "600px")),
                
tabPanel(h4("Figure 1.9"), titlePanel("Edit this code and press 'Evaluate' to change the figure"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig9plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = "
par(family = 'serif', font = 2)

plot(hoursl~rh, data = printedcircuitboard,
     pch = 'X', cex = .85, log = 'y',
     ylim = c(10,10000),xlim = c(45,85))

text(x = c(50,63,75,82), 
     y = c(7000,6000,1000,350), 
     c('48/70 censored',
       '11/68 censored',
       '0/70 censored',
       '0/70 censored'))"),
      
        actionButton("evalfig9", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig9", height = "600px"), width = 7))))

