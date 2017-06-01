################USER INTERFACE BUILD####################

ui <- dashboardPage(skin = "green",
                    
dashboardHeader(title = "WALDO"),
  
dashboardSidebar(
  imageOutput("image",
              width = '100%',
              height = '100%'),
  sidebarMenu(
    menuItem("Tool Overview", 
             tabName = "Tool", 
             icon = icon("info")),
    menuItem("Load Data Files",
             tabName = "Data",
             icon = icon("file")),
    menuItem("Data Table", 
             tabName = "DataTable", 
             icon = icon("database")),
    menuItem("Set Up", 
             tabName = "SetUp", 
             icon = icon("database")),
    menuItem("State Vector", 
             tabName = "StateVector", 
             icon = icon("signal")),
    menuItem("Blocks", 
             tabName = "Blocks", 
             icon = icon("th")))),
  
dashboardBody(
  tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "cyber.css")),
  tabItems(
    # This tab gives users instructions on use
    tabItem(tabName = "Tool",
            fluidRow(
              box(width = 12,
                  includeMarkdown("www/instructions.md")))),
      
    # This tab users select data to be read in to the app
    tabItem(tabName = "Data",
           fluidRow(
              box(width = 4,
                  fileInput("dataFiles",
                            h5('Select a dataset'),
                            accept = c("text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv"))),
        
           actionButton('refreshList', "Update Data"))),
    
    # This tab gives users a searchable table of all data
    tabItem(tabName = "DataTable",
            helpText("This table shows the currently loaded data set."),
            DT::dataTableOutput('original.table')),
      
    tabItem(tabName = "SetUp",
            helpText("This table shows the available Analyst Focused Datasets (AFDs). Multiple AFDs may be selected to load into the analytic."),
            selectizeInput('variables', 
                           "Variables to investigate",
                           c(""),
                           multiple = T,
                           options = list(create = T)),
            actionButton("go","Create State Vector"),
            selectInput("block.levels",
                        label = h3("Choose number of blocks"),
                        choices="")),
              
      tabItem(tabName = "StateVector",
              helpText("This table shows the currently loaded data set."),
              DT::dataTableOutput('SV.table')),
      
      tabItem(tabName = "Histogram Matrix",
              radioButtons("HMAT_choice",
                           label = h3("Select a HMAT to view"),
                           choices=c("Full","Top 20")),
              br(),
              fluidRow(plotOutput("HMAT"))))))

