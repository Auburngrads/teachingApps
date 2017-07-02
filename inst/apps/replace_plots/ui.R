ui = navbarPage(title = 'Replace Plots',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_theme(getShinyOption('theme')),
                header = teachingApps::add_css(),
                footer = teachingApps::add_logo(),


tabPanel(h4("Data Set"),   DT::dataTableOutput("table2", height = "650px") ),  
tabPanel(h4("Data Summary"), verbatimTextOutput("summary2") ), 
tabPanel(h4("Event Plots"),
  sidebarLayout(
  sidebarPanel(width = 3,
  selectInput("PLOT2", 
              label = h2(HTML("<b>Plot:</b>")),
              choices = c("Event Plot",
                          "Histogram"),
              selected = "Event Plot"),
  htmlOutput('breaks')),  
  
  mainPanel( plotOutput("eventplot2", height = "650px"), width = 9))),

tabPanel(h4("CDF Plot"),
  sidebarLayout(
  sidebarPanel(width = 3,
  selectInput("dist2", 
              label = h2(HTML("<b>Distribution:</b>")),
              choices = c("Weibull",
                          "Exponential",
                          "Normal",
                          "Lognormal",                                                
                          "Smallest Extreme Value",
                          "Largest Extreme Value",
                          "Frechet"),
              selected = "Weibull"),

  selectInput("ci2",   
              label = h2(HTML("<b>Confidence Level:</b>")),
              choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
              selected = 0.95),
                   
  selectInput("bt2",
              label = h2(HTML("<b>Band Type:</b>")),
              choices = c("Pointwise", 
                          "Simultaneous", 
                          "none"),
              selected = "Pointwise")), 
  
  mainPanel( plotOutput("cdfplot2", height = "650px"), width = 9))),

tabPanel(h4("MLE Plot"),
  sidebarLayout(
  sidebarPanel(width = 3,
  selectInput("mleplot", 
              label = h2(HTML("<b>Plot Type:</b>")),
              choices = c("CDF Plot",
                          "Hazard Plot", 
                          "Compare CDF Plots"), 
              selected = "CDF Plot"),
  
  selectInput("mledist", 
              label = h2(HTML("<b>Distribution:</b>")),
              choices = c("Weibull",
                          "Exponential",
                          "Normal",
                          "Lognormal",                                                
                          "Smallest Extreme Value",
                          "Largest Extreme Value",
                          "Frechet"), 
              selected = "Weibull"),
  
  htmlOutput('compare'),
  
  selectInput("paramloc", 
              label = h2(HTML("<b>Parameter Location:</b>")),
              choices = c("topleft",
                          "topright",
                          "bottomleft",
                          "bottomright"), 
              selected = "bottomright")),  
  
  mainPanel( plotOutput("mleplot", height = "650px"), width = 9))),

tabPanel(h4("Accelerated Test Plot"),
  sidebarLayout(
  sidebarPanel(width = 3,
  selectInput("altvar", 
              label = h2(HTML("<b>Variance:</b>")),
              choices = c("Non Constant",
                          "Constant"), 
              selected = "Non Constant"),
  
  selectInput("altdist", 
              label = h2(HTML("<b>Distribution:</b>")),
              choices = c("Weibull",
                          "Exponential",
                          "Normal",
                          "Lognormal",  
                          "Smallest Extreme Value",
                          "Largest Extreme Value",
                          "Frechet"), 
              selected = "Weibull")),  
  
  mainPanel( plotOutput("altplot", height = "650px"), width = 9))))

