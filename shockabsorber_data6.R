shockabsorber_data6 <-
function(...) {
  
  library(shiny)
  library(SMRD)
  
par(family = "serif",font = 2)
ShockAbsorber.ld <- frame.to.ld(shockabsorber,
                                response.column = 1, 
                                censor.column = 3, 
                                data.title = "Shock Absorber Data (Both Failure Modes)",
                                time.units = "Kilometers")

shinyApp(options = list(width = "99%", height = "800px"),

ui = navbarPage(theme = shinythemes::shinytheme("flatly"), includeCSS('css/my-shiny.css'),
tabPanel(h4(HTML("<big>Data Set</big>")),   DT::dataTableOutput("table.shock", height = "80%") ),    
tabPanel(h4(HTML("<big>Summary</big>")), verbatimTextOutput("summary.shock") ), 

tabPanel(h4(HTML("<big>Event Plots</big>")),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("PLOT_3", label = h2(HTML("<b>Plot:</b>")),
                    choices = c("Event Plot","Histogram"),
                    selected = "Event Plot")),  
mainPanel( plotOutput("eventplot.shock", height = '650px'), width = 9))),

tabPanel(h4(HTML("<big>CDF Plot</big>")),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("DIST_3", label = h2(HTML("<b>Distribution:</b>")),
                    choices = c("Weibull","Exponential","Normal","Lognormal",                                                "Smallest Extreme Value","Largest Extreme Value","Frechet"), 
                    selected = "Weibull"),

selectInput("CI_3",   label = h2(HTML("<b>Confidence Level:</b>")),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("BT_3",   label = h2(HTML("<b>Band Type:</b>")),
                    choices = c("Pointwise", "Simultaneous", "none"), 
                    selected = "Pointwise")),  

mainPanel( plotOutput("cdfplot.shock", height = '650px'), width = 9)))),

server = function(input, output, session) {
           
output$table.shock <- DT::renderDataTable({ DT::datatable(ShockAbsorber.ld,
                                                          options = list(pageLength = 12)) })

output$summary.shock <- renderPrint({ summary(ShockAbsorber.ld)                        })

output$eventplot.shock <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_3 == "Event Plot") event.plot(ShockAbsorber.ld) 
  if (input$PLOT_3 == "Histogram") hist(SMRD:::Response(ShockAbsorber.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(ShockAbsorber.ld,"time.units"))})

output$cdfplot.shock <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(ShockAbsorber.ld, distribution = input$DIST_3, 
     conf.level = as.numeric(input$CI_3), band.type = input$BT_3) 
})
})
}
