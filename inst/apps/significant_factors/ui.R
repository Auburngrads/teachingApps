ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     selectInput('response',
                 h4('Choose Response'),
                 choices = colnames(mtcars2),
                 selectize = T),
     
     htmlOutput('factors')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)))
