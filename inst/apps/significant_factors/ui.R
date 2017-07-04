ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_css(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     selectInput('response',
                 'Choose Response',
                 choices = colnames(mtcars),
                 selectize = T),
     
     htmlOutput('factors')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)))
