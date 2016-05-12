turbine_data6 <-
function(...) {
  
  if(!isNamespaceLoaded('shiny'))  attachNamespace('shiny')
  if(!isNamespaceLoaded('SMRD'))  attachNamespace('SMRD')
  
par(family = "serif",font = 2)
Turbine.ld <- frame.to.ld(SMRD:::datas$turbine,
                          response.column = 1,
                          censor.column = 2,
                          case.weight.column=3,
                          data.title = "Turbine Wheel Data Set",
                          time.units = "Hundred Hours")

shinyApp(options = list(width = "99%", height = "800px"),
ui = navbarPage(theme = shinythemes::shinytheme("flatly"), includeCSS('css/my-shiny.css'),

tabPanel(h4("Data Set"),  DT::dataTableOutput("table.turb", height = "80%") ),    

tabPanel(h4("Summary"), verbatimTextOutput("summary.turb") ), 

tabPanel(h4("Event Plots"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("PLOT_5", label = h2("Plot:"),
                    choices = c("Event Plot","Histogram"),
                    selected = "Event Plot")),  
mainPanel( plotOutput("eventplot.turb", height = '650px'), width = 9))),

tabPanel(h4("CDF Plot"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("DIST_5", label = h2("Distribution:"),
                    choices = c("Weibull","Exponential","Normal","Lognormal",                                                "Smallest Extreme Value","Largest Extreme Value","Frechet"), 
                    selected = "Weibull"),

selectInput("CI_5",   label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("BT_5",   label = h2("Band Type:"),
                    choices = c("Pointwise", "Simultaneous", "none"), 
                    selected = "Pointwise")),  
mainPanel( plotOutput("cdfplot.turb", height = '650px'), width = 9)))),

server = function(input, output, session) {
  
output$table.turb <- DT::renderDataTable({ DT::datatable(Turbine.ld,
                                                          options = list(pageLength = 12)) })

output$summary.turb <- renderPrint({ summary(Turbine.ld)                        })

output$eventplot.turb <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_5 == "Event Plot") event.plot(Turbine.ld) 
  if (input$PLOT_5 == "Histogram") hist(Response(Turbine.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Turbine.ld,"time.units"))})

output$cdfplot.turb <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Turbine.ld, distribution = input$DIST_5, 
     conf.level = as.numeric(input$CI_5), band.type = input$BT_5) 
})
})
}
