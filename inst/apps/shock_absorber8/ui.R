library(teachingApps)
library('SMRD')

ui = navbarPage(title = 'Shock Absorber',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                     
tabPanel(h4("Data Set"),   DT::dataTableOutput("table.shock", height = "80%") ),    
tabPanel(h4("Summary"), verbatimTextOutput("summary.shock")), 
tabPanel(h4("Event Plots"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("PLOT_3", 
                  label = h2("Plot Type"),
                  choices = c("Event Plot","Histogram"),
                  selected = "Event Plot")),  
    
mainPanel( plotOutput("eventplot.shock", height = '600px'), width = 9))),

tabPanel(h4("CDF Plot"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("DIST_3", 
                  label = h2("Distribution"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),

      selectInput("CI_3",
                  label = h2("Confidence Level"),
                  choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                  selected = 0.95),
                   
      selectInput("BT_3",
                  label = h2("Band Type"),
                  choices = c("Pointwise", 
                              "Simultaneous", 
                              "none"),
                  selected = "Pointwise")),  

mainPanel( plotOutput("cdfplot.shock", height = '600px'), width = 9))),

tabPanel(h4("MLE Plot"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("mleplot", 
                  label = h2("Plot Type"),
                  choices = c("CDF Plot",
                             "Hazard Plot", 
                             "Compare CDF Plots"), 
                  selected =  "CDF Plot"),

      selectInput("mledist", 
                  label = h2("Distribution"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                       
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                   selected = "Weibull"),

      selectInput("mlecomp", 
                  label = h2("Compare Distribution"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                      
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),

      selectInput("paramloc", 
                  label = h2("Parameter Location"),
                  choices = c("topleft",
                              "topright",
                              "bottomleft",
                              "bottomright"), 
                  selected = "bottomright")),  
    
mainPanel( plotOutput("mleplot", height = '600px'), width = 9))),

tabPanel(h4('Code Mirror'),
         
mainPanel(codemirrorR::codemirrorOutput('mlemirror', height = '600px'), width = 12)))
