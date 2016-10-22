library(teachingApps)
library('SMRD')

par(family="serif",font=2)
at7987.ld <- frame.to.ld(SMRD::at7987,
                         response.column = 1,
                         censor.column = 2,
                         case.weight.column = 3,
                         data.title = "Alloy t7987 Data",
                         time.units = "Kilocycles")


shinyApp(options = list(width = "99%", height = "800px"),

ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'at7987',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),

tabPanel(h4("Data Set"),DT::dataTableOutput("table.at7987", height = "80%") ), 

tabPanel(h4("Summary"), verbatimTextOutput("summary.at7987") ), 

tabPanel(h4("Event Plots"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("PLOT_2", label = h2("Plot:"),
            choices = c("Event Plot","Histogram"),
            selected = "Event Plot")),  
mainPanel( plotOutput("eventplot.at7987", height = '650px'), width = 9))),

tabPanel(h4("CDF Plot"),
sidebarLayout(
sidebarPanel(width = 3,
selectInput("dist_2", 
            label = h2("Distribution:"),
            choices = c("None",
                        "Weibull",
                        "Exponential",
                        "Normal",
                        "Lognormal",
                        "Smallest Extreme Value",
                        "Largest Extreme Value","Frechet"), 
            selected = "Weibull"),

selectInput("ci_2",   label = h2("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
                   
selectInput("bt_2",   
            label = h2("Band Type:"),
            choices = c("Pointwise", 
                        "Simultaneous", 
                        "none"), 
            selected = "Pointwise")),  

mainPanel( plotOutput("cdfplot.at7987", height = '650px'), width = 9))),

tabPanel(h4('Code Mirror'), 
         mainPanel(codemirrorR::codemirrorOutput('figures', height = '650px'), width = 12))),

server = function(input, output, session) {
  
output$table.at7987 <- DT::renderDataTable({ DT::datatable(at7987.ld,
                                                           options = list(pageLength = 10)) })
  
output$summary.at7987 <- renderPrint({ summary(at7987.ld)                        })

output$eventplot.at7987 <- renderPlot({ 
  par(family = "serif",bg = NA, font = 2)
  if (input$PLOT_2 == "Event Plot") event.plot(at7987.ld) 
  if (input$PLOT_2 == "Histogram") hist(Response(at7987.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(at7987.ld,"time.units"))})

output$cdfplot.at7987 <- renderPlot({
  par(family = "serif",bg = NA, font = 2)
  plot(at7987.ld, 
       distribution = switch(input$dist_2, 
                             'None'    = NULL,
                             "Weibull" = "Weibull",
                             "Exponential" = "Exponential",
                             "Normal" = 'Normal',
                             "Lognormal" = 'Lognormal',
                             "Smallest Extreme Value" = 'sev',
                             "Largest Extreme Value" = 'lev',
                             "Frechet" = "Frechet" ), 
     conf.level = as.numeric(input$ci_2), band.type = input$bt_2) 
})

output$figures <- codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r',
"
## R code for Figures 6.5, 6.6, and 6.7

## Figure 6.5

at7987.ld <- frame.to.ld(SMRD::at7987,
                         response.column = 1,
                         censor.column = 2,
                         case.weight.column = 3,
                         data.title = 'Alloy t7987 Data',
                         time.units = 'Thousand Cycles')
plot(at7987.ld)

## Figure 6.6

par(family='serif',font=2)
plot(at7987.ld,distribution='Weibull')

## Figure 6.7

par(family='serif',font=2)
plot(at7987.ld,distribution='Lognormal')")

})
})
