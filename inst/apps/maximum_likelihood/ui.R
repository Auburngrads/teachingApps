library(teachingApps)
library('scales')


ui <- fluidPage(theme = shinythemes::shinytheme(theme = getShinyOptions("theme")), 
                tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
               
sidebarLayout(
  sidebarPanel(width = 4,
    selectInput('correct', 
                label = h2('True Distribution'), 
                choices = c('Green', 
                            'Blue', 
                            'Red'), 
                selected = 'Blue'),
    
    actionButton('mlesample',h4('sample 1'), width = '100%'),
    hr(),
    actionButton('mlesample10',h4('sample 10'), width = '100%'),
    hr(),
    actionButton('clear',h4('clear'), width = '100%')),
  
  mainPanel(plotOutput('plotmle', height = '650px'), width = 8)),

if(!getShinyOptions("story")) 
     fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))

