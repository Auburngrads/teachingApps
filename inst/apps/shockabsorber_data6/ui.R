library(teachingApps)
library('SMRD')

par(family = "serif",font = 2)
ShockAbsorber.ld <- frame.to.ld(SMRD::shockabsorber,
                                response.column = 1, 
                                censor.column = 3, 
                                data.title = "Shock Absorber Data (Both Failure Modes)",
                                time.units = "Kilometers")

ui = navbarPage(title = 'Shockabsorber Example6',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4("Data Set"),   DT::dataTableOutput("table.shock", height = "80%") ),    
tabPanel(h4("Summary"), verbatimTextOutput("summary.shock") ), 

tabPanel(h4("Event Plots"),
sidebarLayout(
   sidebarPanel(width = 3,
      selectInput("PLOT_3", 
                  label = h2("Plot:"),
                  choices = c("Event Plot",
                              "Histogram"),
                  selected = "Event Plot")),

    mainPanel( plotOutput("eventplot.shock", height = '650px'), width = 9))),

tabPanel(h4("CDF Plot"),
sidebarLayout(
   sidebarPanel(width = 3,
      selectInput("DIST_3", 
                  label = h2("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",
                              "Smallest Extreme Value",
                              "Largest Extreme Value","Frechet"), 
                  selected = "Weibull"),

      selectInput("CI_3",   
                  label = h2("Confidence Level:"),
                  choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                  selected = 0.95),
                   
      selectInput("BT_3",   
                  label = h2("Band Type:"),
                  choices = c("Pointwise", "Simultaneous", "none"), 
                  selected = "Pointwise")),  

   mainPanel( plotOutput("cdfplot.shock", height = '650px'), width = 9))))

