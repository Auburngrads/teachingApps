library(teachingApps)
library('SMRD')

par(family = "serif",font = 2)
ShockAbsorber.ld <- frame.to.ld(SMRD::shockabsorber,
                                response.column = 1, 
                                censor.column = 3, 
                                data.title = "Shock Absorber Data (Both Failure Modes)",
                                time.units = "Kilometers")

shinyApp(options = list(width = "99%", height = "800px"),

ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Shockabsorber Example6',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),
                
tabPanel(h4("Data Set"),   DT::dataTableOutput("table.shock", height = "80%") ),    
tabPanel(h4("Summary"), verbatimTextOutput("summary.shock") ), 

tabPanel(h4("Event Plots"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("PLOT_3", label = h2("Plot:"),
                    choices = c("Event Plot",
                                "Histogram"),
            selected = "Event Plot")),
mainPanel( plotOutput("eventplot.shock", height = '650px'), width = 9))),

tabPanel(h4("CDF Plot"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("DIST_3", label = h2("Distribution:"),
                    choices = c("Weibull",
                                "Exponential",
                                "Normal",
                                "Lognormal",
                                "Smallest Extreme Value",
                                "Largest Extreme Value","Frechet"), 
                    selected = "Weibull"),

selectInput("CI_3",   label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("BT_3",   label = h2("Band Type:"),
                    choices = c("Pointwise", "Simultaneous", "none"), 
                    selected = "Pointwise")),  

mainPanel( plotOutput("cdfplot.shock", height = '650px'), width = 9)))),

server = function(input, output, session) {
  
output$table.shock <- DT::renderDataTable({ 
  
  DT::datatable(ShockAbsorber.ld, options = list(pageLength = 10)) })

output$summary.shock <- renderPrint({ 
  
  summary(ShockAbsorber.ld)                        })

output$eventplot.shock <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_3 == "Event Plot") event.plot(ShockAbsorber.ld) 
  if (input$PLOT_3 == "Histogram") hist(Response(ShockAbsorber.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(ShockAbsorber.ld,"time.units"))})

output$cdfplot.shock <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(ShockAbsorber.ld, distribution = input$DIST_3, 
     conf.level = as.numeric(input$CI_3), band.type = input$BT_3) 
})
})
