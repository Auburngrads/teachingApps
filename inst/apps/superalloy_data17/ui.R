ui = navbarPage(title = 'Superalloy Example',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),


tabPanel("Data Set",   DT::dataTableOutput("table2", height = "80%") ),    

tabPanel("Summary", verbatimTextOutput("summary2") ), 

tabPanel("Event Plots",
  sidebarLayout(
  sidebarPanel(
  selectInput("PLOT2", 
              label = "Plot:",
              choices = c("Event Plot",
                          "Histogram"),
              selected = "Event Plot")),  
  mainPanel( plotOutput("eventplot2")))),

tabPanel("CDF Plot",
  sidebarLayout(
  sidebarPanel(
  selectInput("dist2", label = "Distribution:",
                       choices = c("Weibull",
                                   "Exponential",
                                   "Normal",
                                   "Lognormal",                                                
                                   "Smallest Extreme Value",
                                   "Largest Extreme Value",
                                   "Frechet"), 
                      selected = "Weibull"),
  br(),
  selectInput("ci2", label = "Confidence Level:",
                     choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                     selected = 0.95),
  br(),
  selectInput("bt2", label = "Band Type:",
                     choices = c("Pointwise", 
                                 "Simultaneous", 
                                 "none"), 
                     selected = "Pointwise")),  
  
      mainPanel( plotOutput("cdfplot2", height = '600px')))),

tabPanel("MLE Plot",
  sidebarLayout(
  sidebarPanel(
  selectInput("mleplot", 
              label = "Plot Type:",
              choices = c("CDF Plot",
                          "Hazard Plot"), 
              selected = "CDF Plot"),
  
  selectInput("mledist", 
              label = "Distribution:",
              choices = c("Weibull",
                          "Exponential",
                          "Normal",
                          "Lognormal",                                                
                          "Smallest Extreme Value",
                          "Largest Extreme Value",
                          "Frechet"), 
              selected = "Weibull"),
  
  selectInput("paramloc", 
              label = "Parameter Location:",
              choices = c("topleft",
                          "topright",
                          "bottomleft",
                          "bottomright"), 
              selected = "bottomright")),  
  
  mainPanel( plotOutput("mleplot")))))

