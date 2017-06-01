library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Zelen Cap',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),

    tabPanel(h4("Data Set"), DT::dataTableOutput("table2", height = "565px") ),    
    tabPanel(h4("Summary"),  verbatimTextOutput("summary2") ), 

    tabPanel(h4("Event Plots"),
      sidebarLayout(
      sidebarPanel(
        
      selectInput("PLOT2", 
                  label = h2("Plot Type:"),
                  choices = c("Event Plot",
                              "Histogram"),
                  selected = "Event Plot")),  
      
      mainPanel( plotOutput("eventplot2", height = "565px")))),

    tabPanel(h4("CDF Plot"),
      sidebarLayout(
      sidebarPanel(
        
        selectInput("dist2", 
                    label = h2("Distribution:"),
                    choices = c("Weibull",
                                "Exponential",
                                "Normal",
                                "Lognormal",                                                
                                "Smallest Extreme Value",
                                "Largest Extreme Value",
                                "Frechet"), 
                    selected = "Weibull"),
        
        selectInput("ci2",   
                    label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
        
        selectInput("bt2",   
                    label = h2("Band Type:"),
                    choices = c("Pointwise", 
                                "Simultaneous", 
                                "none"), 
                    selected = "Pointwise")), 
      
      mainPanel( plotOutput("cdfplot2",height = "565px")))),
    
  tabPanel(h4("MLE Plot"),
    sidebarLayout(
    sidebarPanel(
      selectInput("mleplot", 
                  label = h2("Plot Type:"),
                  choices = c("CDF Plot",
                              "Hazard Plot"), 
                  selected = "CDF Plot"),
      
      selectInput("mledist", 
                  label = h2("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                                                
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),
      
      selectInput("paramloc", 
                  label = h2("Parameter Location:"),
                  choices = c("topleft",
                              "topright",
                              "bottomleft",
                              "bottomright"), 
                  selected = "bottomright")),
    
    mainPanel( plotOutput("mleplot",height = "565px")))),

  tabPanel(h4("ALT Plot"),
    sidebarLayout(
    sidebarPanel(
      selectInput("altvar", 
                  label = h2("Variance:"),
                  choices = c("Non Constant",
                              "Constant"), 
                  selected = "Non Constant"),
      
      selectInput("altdist", 
                  label = h2("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                                                
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull")),
    
    mainPanel( plotOutput("altplot",height = "565px")))))
