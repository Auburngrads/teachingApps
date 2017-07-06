ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
sidebarLayout(
  sidebarPanel(width = 4,
    selectInput('correct', 
                label = 'True Distribution', 
                choices = c('Green', 
                            'Blue', 
                            'Red'), 
                selected = 'Blue'),
    
    actionButton('mlesample','sample 1', width = '100%'),
    hr(),
    actionButton('mlesample10','sample 10', width = '100%'),
    hr(),
    actionButton('clear','clear', width = '100%')),
  
  mainPanel(plotOutput('plotmle', height = '650px'), width = 8)))

