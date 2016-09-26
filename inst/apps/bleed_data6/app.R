library(pos = -1,  package = 'SMRD')










  
Bleed.ld <- frame.to.ld(SMRD::bleed,
                        response.column = 1, 
                        censor.column = 2, 
                        case.weight.column = 3,
                        x.columns = c(4),
                        data.title = "Bleed Failure Data",
                        time.units = "Hours")
Bleed.Dbase.ld <-     ld.split(Bleed.ld, stress.var.list = "D")
Bleed.Otherbase.ld <- ld.split(Bleed.ld, stress.var.list = "Other")
  
load('args.Rdata')
shinyApp(options = list(width = '99%', height = '800px'),
ui = navbarPage(theme = shinythemes::shinytheme(theme = arg2$theme),
               try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
                
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

selectInput("CI_6",   label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("BT_6",   label = h2("Band Type:"),
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
          width = 12)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


output$table.bleed <- DT::renderDataTable({ DT::datatable(Bleed.ld,
                                                          options = list(pageLength = 12)) })

output$summary.bleed   <- renderPrint({ summary(Bleed.ld)                      })
output$summary.bleed.d <- renderPrint({ summary(Bleed.Dbase.ld)                })
output$summary.bleed.o <- renderPrint({ summary(Bleed.Otherbase.ld)            })


output$eventplot.bleed <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$PLOT_6 == "Event Plot") event.plot(Bleed.ld) 
  if (input$PLOT_6 == "Histogram") hist(Response(Bleed.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Bleed.ld,"time.units"))
})
output$eventplot.bleed.d <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$PLOT_6 == "Event Plot") event.plot(Bleed.Dbase.ld) 
  if (input$PLOT_6 == "Histogram") hist(Response(Bleed.Dbase.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Bleed.ld,"time.units"))
})
output$eventplot.bleed.o <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$PLOT_6 == "Event Plot") event.plot(Bleed.Otherbase.ld) 
  if (input$PLOT_6 == "Histogram") hist(Response(Bleed.Otherbase.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(Bleed.ld,"time.units"))
})
output$cdfplot.bleed <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Bleed.ld, distribution = input$DIST_6, 
     conf.level = as.numeric(input$CI_6), band.type = input$BT_6) 
})
output$cdfplot.bleed.d <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Bleed.Dbase.ld, distribution = input$DIST_6, 
     conf.level = as.numeric(input$CI_6), band.type = input$BT_6) 
})
output$cdfplot.bleed.o <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  plot(Bleed.Otherbase.ld, distribution = input$DIST_6, 
     conf.level = as.numeric(input$CI_6), band.type = input$BT_6) 
})
output$figures.bleed <- codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r',
"
Bleed.ld <- frame.to.ld(SMRD::bleed,
                        response.column = 1, 
                        censor.column = 2, 
                        case.weight.column = 3,
                        x.columns = c(4),
                        data.title = 'Bleed Failure Data',
                        time.units = 'Hours')
stressor.ld(Bleed.ld, stress.var = 'D', print = FALSE)
stressor.ld(Bleed.ld, stress.var = 'Other')")
  
})
})
