ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput('response',
                  label = 'Select a Response Variable',
                  choices = colnames(map_data)[-1],
                  selected = colnames(map_data)[7]),
      uiOutput('reduced')),
                   
  
  mainPanel(
  tabsetPanel(
    tabPanel("Plot", plotOutput("plot")),
    tabPanel("Summary", verbatimTextOutput("summary")),
    tabPanel("Table", tableOutput("table"))
  )
)))
