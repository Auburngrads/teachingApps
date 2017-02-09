library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Zelen Cap',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),

    tabPanel(h2("Data Set"), DT::dataTableOutput("table2", height = "565px") ),    
    tabPanel(h2("Summary"),  verbatimTextOutput("summary2") ), 

    tabPanel(h2("Event Plots"),
      sidebarLayout(
      sidebarPanel(
        
      selectInput("PLOT2", 
                  label = h4("Plot Type:"),
                  choices = c("Event Plot",
                              "Histogram"),
                  selected = "Event Plot")),  
      
      mainPanel( plotOutput("eventplot2", height = "565px")))),

    tabPanel(h2("CDF Plot"),
      sidebarLayout(
      sidebarPanel(
        
        selectInput("dist2", 
                    label = h4("Distribution:"),
                    choices = c("Weibull",
                                "Exponential",
                                "Normal",
                                "Lognormal",                                                
                                "Smallest Extreme Value",
                                "Largest Extreme Value",
                                "Frechet"), 
                    selected = "Weibull"),
        
        selectInput("ci2",   
                    label = h4("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
        
        selectInput("bt2",   
                    label = h4("Band Type:"),
                    choices = c("Pointwise", 
                                "Simultaneous", 
                                "none"), 
                    selected = "Pointwise")), 
      
      mainPanel( plotOutput("cdfplot2",height = "565px")))),
    
  tabPanel(h2("MLE Plot"),
    sidebarLayout(
    sidebarPanel(
      selectInput("mleplot", 
                  label = h4("Plot Type:"),
                  choices = c("CDF Plot",
                              "Hazard Plot"), 
                  selected = "CDF Plot"),
      
      selectInput("mledist", 
                  label = h4("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                                                
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),
      
      selectInput("paramloc", 
                  label = h4("Parameter Location:"),
                  choices = c("topleft",
                              "topright",
                              "bottomleft",
                              "bottomright"), 
                  selected = "bottomright")),
    
    mainPanel( plotOutput("mleplot",height = "565px")))),

  tabPanel(h2("ALT Plot"),
    sidebarLayout(
    sidebarPanel(
      selectInput("altvar", 
                  label = h4("Variance:"),
                  choices = c("Non Constant",
                              "Constant"), 
                  selected = "Non Constant"),
      
      selectInput("altdist", 
                  label = h4("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                                                
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull")),
    
    mainPanel( plotOutput("altplot",height = "565px")))))
