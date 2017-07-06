ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     selectInput('response',
                 'Choose Response',
                 choices = colnames(mtcars),
                 selectize = T),
     
     htmlOutput('factors')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)))
