ui = navbarPage(title = 'International Logistics Performance Index',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

 tabPanel('Global Ranking',
    sidebarLayout(
       sidebarPanel(width = 4,
          helpText("Modify the map and data table by selecting desired information below."),
          selectInput("metric", 
                      label = "Choose a metric to display",
                      choices = names(lpi)[c(3, 5:10)],
                      selected = "Overall LPI Score"),
                        
          radioButtons("range", 
                       label = "Choose a year to display",
                       choices = list("Average" = "Average",
                                      "2016" = 2016, 
                                      "2014" = 2014,
                                      "2012" = 2012, 
                                      "2010" = 2010),
                       selected = "Average"),
                        
          checkboxInput("alldata", 
                        label = "Show all data in table", 
                        value = FALSE),
                        
          downloadButton('downloadData', 'Download Table'),
                        
          helpText("The", 
                   a("Logistics Performance Index (LPI)", 
                     href = "http://lpi.worldbank.org/"),
                   "is a benchmarking tool created to assess and compare the performance of 150+ countries on trade logistics. This map and the data table that follows illustrate the performance of countries across the world in each of the LPI metrics. Read more in the background section.")),

       mainPanel(width = 8,
        tabsetPanel(type = 'pills',
          tabPanel('Interactive Map of Results',
            htmlOutput("mapTitle", 
                       container = span,
                       style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;", 
                       align='center'),
            
            plotlyOutput("trendPlot", width = '95%', height = '500px')),
            #htmlOutput("mapDesc")),
          
          tabPanel('Full Table of Results',  
            DT::dataTableOutput("mapTable")))))),
        
  tabPanel('Country Score Card',
    sidebarLayout(
       sidebarPanel(width = 3,
         helpText("Modify the map and data table by selecting desired information below."),
         selectInput("country", 
                     label = "Choose a country to display",
                     choices = sort(unique(lpi$`Country`)),
                     selected = "United States"),
                         
          checkboxGroupInput('selectedYears', 
                             "Years to include in Radar Chart",
                             seq(2010, 2016, by = 2),
                             selected = seq(2010, 2016, by = 2)),
                         
          helpText("The country scorecard uses six key dimensions to benchmark countries' performance and also displays the derived overall LPI score. The plot illustrates the score the selected country has achieved for each metric and the data table displays how the selected country ranks among the world in regards to each metric.")),

      mainPanel(width = 9,
        tabsetPanel(type = 'pills',
          tabPanel('Radar Plot',    
            htmlOutput("radarTitle", 
                       container = span, 
                       style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;", 
                       align = 'center'),
            br(),
            chartJSRadarOutput("radarPlot", width = "500", height = "250"),
            br(),
            htmlOutput("radarDesc")),
          
          tabPanel('Table of Results',
            DT::dataTableOutput("radarTable"))))))
        
    # tabPanel('Background', 
    #          fluidRow(includeMarkdown('include.Rmd')))
)

