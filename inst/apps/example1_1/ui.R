library(teachingApps)
library('SMRD')
         
ui = navbarPage(title = 'Example 1.1',
                position = 'fixed-top',
                collapsible = T, 
                theme = shinythemes::shinytheme(getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4('Background'),
         mainPanel(uiOutput('example1.1'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Table 1.1"), 
         titlePanel(HTML('SMRD data object: <code>lzbearing</code>')),
         DT::dataTableOutput("lzbearing", height = "600px")),

navbarMenu(h4('Figures'), icon = icon('bar-chart-o'),       
tabPanel(h4("Figure 1.1"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "fig1plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = "
library(SMRD)

par(family = 'serif', font = 2)

hist(SMRD::lzbearing$mcycles,
     breaks = seq(0,200,20),
     col = 'black',
     border = 'white',
     prob = TRUE,
     main = 'Figure 1.1 - Histogram of the ball bearing failure data',
     las = 1)"),
      
        actionButton("evalfig1", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig1", height = "600px"), width = 7))),

tabPanel(h4("Figure 1.2"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "fig2plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"library(SMRD)

par(family='serif', font=2)

lzbearing.ld <- frame.to.ld(SMRD::lzbearing, 
                            response.column = 1, 
                            time.units = 'Megacycles')

event.plot(lzbearing.ld)"),

        actionButton("evalfig2", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig2", height = "600px"), width = 7)))))
