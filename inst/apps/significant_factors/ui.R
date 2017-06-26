ui = fluidPage(theme = teachingApps::add_themes(getShinyOption("theme")), 
               teachingApps::add_styles(),
               
sidebarLayout( 
  sidebarPanel(width = 5,
     selectInput('response',
                 h4('Choose Response'),
                 choices = colnames(mtcars2),
                 selectize = T),
     
     htmlOutput('factors')),
        
     mainPanel(plotOutput("output", height = '600px'), width = 7)))
