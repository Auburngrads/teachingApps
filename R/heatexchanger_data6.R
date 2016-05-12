heatexchanger_data6 <-
function(...) {
  
  loadNamespace('shiny')
  loadNamespace('SMRD')
  
par(family = "serif",font = 2)
HeatExchanger.ld <- frame.to.ld(SMRD::heatexchanger,
                                response.column = c(1,2),
                                censor.column = 3,
                                case.weight.column=4,
                                data.title = "Heat Exchanger Crack Data",
                                time.units = "Years")

shinyApp(options = list(width = "99%", height = "800px"),

ui = navbarPage(theme = shinythemes::shinytheme("flatly"),
                includeCSS('css/my-shiny.css'),
                
tabPanel(h4("Data Set"),   DT::dataTableOutput("table.heat", height = "80%") ),

tabPanel(h4("Summary"), verbatimTextOutput("summary.heat") ), 

tabPanel(h4("Event Plots"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("PLOT_4", label = h2("Plot:"),
                    choices = c("Event Plot","Histogram"),
                    selected = "Event Plot")),  
mainPanel( plotOutput("eventplot.heat", height = '650px'), width = 9))),

tabPanel(h4("CDF Plot"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("DIST_4", label = h2("Distribution:"),
                    choices = c("Weibull",
                                "Exponential",
                                "Normal",
                                "Lognormal",
                                "Smallest Extreme Value",
                                "Largest Extreme Value",
                                "Frechet"), 
                    selected = "Weibull"),

selectInput("CI_4",   label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("BT_4",   label = h2("Band Type:"),
                    choices = c("Pointwise", "Simultaneous", "none"), 
                    selected = "Pointwise")),  
mainPanel( plotOutput("cdfplot.heat", height = '650px'), width = 9)))),

server = function(input, output, session) {
           
output$table.heat <- DT::renderDataTable({ 
  
  DT::datatable(HeatExchanger.ld, options = list(pageLength = 12)) })

output$summary.heat <- renderPrint({ 
  
  summary(HeatExchanger.ld)                        })

output$eventplot.heat <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_4 == "Event Plot") event.plot(HeatExchanger.ld) 
  if (input$PLOT_4 == "Histogram") hist(Response(HeatExchanger.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(HeatExchanger.ld,"time.units"))})

output$cdfplot.heat <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(HeatExchanger.ld, distribution = input$DIST_4, 
     conf.level = as.numeric(input$CI_4), band.type = input$BT_4) 
})
})
}
