library(teachingApps)
library('SMRD')


Bleed.ld <- frame.to.ld(SMRD::bleed,
                        response.column = 1, 
                        censor.column = 2, 
                        case.weight.column = 3,
                        x.columns = c(4),
                        time.units = "Hours")

Bleed.Dbase.ld <-     ld.split(Bleed.ld, stress.var.list = "D")
Bleed.Otherbase.ld <- ld.split(Bleed.ld, stress.var.list = "Other")


ui = navbarPage(title = 'Bleed Data Set',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                              tags$head(includeCSS("www/custom.css"))),
                footer = HTML(teachingApps::signature(getShinyOption("appName"))),
                
tabPanel(h4("Data Set"),   DT::dataTableOutput("table.bleed", height = "80%") ), 

tabPanel(h4("Summary"), 
mainPanel(width = 12,
  tabsetPanel(
    tabPanel(h4("Bases: All"),   verbatimTextOutput("summary.bleed")),
    tabPanel(h4("Bases: D"),     verbatimTextOutput("summary.bleed.d")),
    tabPanel(h4("Bases: Other"), verbatimTextOutput("summary.bleed.o"))))), 

tabPanel(h4("Event Plots"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("PLOT_6", label = h2("Plot:"),
                    choices = c("Event Plot","Histogram"),
                    selected = "Event Plot")),  
mainPanel( width = 9,
  tabsetPanel(
tabPanel(h4("Bases: All"),   plotOutput("eventplot.bleed",   height = '600px')),
tabPanel(h4("Bases: D"),     plotOutput("eventplot.bleed.d", height = '600px')),
tabPanel(h4("Bases: Other"), plotOutput("eventplot.bleed.o", height = '600px'))
)))),

tabPanel(h4("CDF Plot"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("DIST_6", label = h2("Distribution:"),
                    choices = c("Weibull",
                                "Exponential",
                                "Normal",
                                "Lognormal",
                                "Smallest Extreme Value",
                                "Largest Extreme Value","Frechet"), 
                    selected = "Weibull"),

selectInput("CI_6", label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("BT_6", label = h2("Band Type:"),
                    choices = c("Pointwise", "Simultaneous", "none"), 
                    selected = "Pointwise")),  

mainPanel( width = 9,
  tabsetPanel(
tabPanel(h4("Bases: All"),   plotOutput("cdfplot.bleed",   height = '600px')),
tabPanel(h4("Bases: D"),     plotOutput("cdfplot.bleed.d", height = '600px')),
tabPanel(h4("Bases: Other"), plotOutput("cdfplot.bleed.o", height = '600px'))
)))),

tabPanel(h4('Code Mirror'), 

mainPanel(codemirrorR::codemirrorOutput('figures.bleed', height = '600px'), 
          width = 12)))
