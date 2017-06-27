library(teachingApps)
library('SMRD')

ui = fluidPage(theme = teachingApps::add_theme(getShinyOption("theme")), 
               teachingApps::add_style(),
     
sidebarLayout(           
  sidebarPanel(width = 3,           
    selectInput("n7.2", 
                label = h2("Observations"),
                choices = c(20, 200, 2000, 10220), 
                selected = 20),
  
    selectInput("ci7.2", 
                label = h2("Confidence Level"),
                choices = c("50","80","90","95","99"), 
                selected = "95")),
  
  mainPanel(plotOutput('berksonrel', height = '600px'), width = 9)))
