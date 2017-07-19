
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

ui <- fluidPage(title = 'Census',
                theme = shinythemes::shinytheme('flatly'),

  # Application title
  titlePanel("USA Census Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(width = 3,
      sliderInput("num_colors",
                  label = "Number of colors:",
                  min = 1,
                  max = 9,
                  value = 7),
      selectInput("select", 
                  label = "Select Demographic:", 
                  choices = colnames(map_data)[2:9], 
                  selected = 1)),

    # Show a plot of the generated distribution
    mainPanel(width = 9,
      tabsetPanel( 
        tabPanel('Output Map', plotOutput("map")),
        tabPanel('Data Table', dataTableOutput('table'))))))
