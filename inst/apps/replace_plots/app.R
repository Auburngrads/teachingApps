library(pos = -1,  package = 'SMRD')










  
ZelenCap.ld <- frame.to.ld(SMRD::zelencap, 
                           response.column = 1, 
                           censor.column = 2, 
                           case.weight.column = 3,
                           x.columns = c(4, 5), 
                           time.units = "Hours", 
                           xlabel = c(expression(C^o), expression("Volts")))

shinyApp(options = list(width = "100%", height = "800px"),

    ui = navbarPage(theme = shinythemes::shinytheme("flatly"),
                    try(includeCSS(system.file('css','my-shiny.css', 
                                               package = 'teachingApps')),  silent = TRUE),

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
  
  mainPanel( plotOutput("altplot", height = "650px"), width = 9))),
           
fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

observe({
  
  if(input$mleplot=='Compare CDF Plots') {
    
  output$compare <- renderUI({
    
    
selectInput("mlecomp", label = h2("Compare Distribution"),
                      choices = c("Weibull",
                                  "Exponential",
                                  "Normal",
                                  "Lognormal",                      
                                  "Smallest Extreme Value",
                                  "Largest Extreme Value",
                                  "Frechet"), 
                      selected = "Lognormal")
})
  
  } else { output$compare <- renderUI({

selectInput("cimle2",   
            label = h2(HTML("<b>Confidence Level:</b>")),
            choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
            selected = 0.95) 
}) 
}
  
  if(input$PLOT2 == 'Histogram') {
    
    output$breaks <- renderUI({
      
      sliderInput('histbreaks', 
                  h2('Number of Bins'), 
                  min = 5, 
                  max = 50, 
                  step = 5, 
                  value = 5)
}) 
} else { output$breaks <- renderUI({NULL }) }
})
  
  output$summary2 <- renderPrint({ summary(ZelenCap.ld)                        
})
  output$table2 <- DT::renderDataTable({ DT::datatable(ZelenCap.ld,options =    
                                                         list(pageLength = 12)) 
})
  output$eventplot2 <- renderPlot({ 
  par(family = "serif",font = 2)
  if (input$PLOT2 == "Event Plot") event.plot(ZelenCap.ld) 
  if (input$PLOT2 == "Histogram") hist(Response(ZelenCap.ld), 
                                      probability = TRUE, 
                                      col = 1, 
                                      border = "white", 
                                      main = "", 
                                      xlab = attr(ZelenCap.ld,"time.units"),
                                      breaks = input$histbreaks,
                                      las = 1)
})
  output$cdfplot2 <- renderPlot({ 
  par(family = "serif", font = 2)
  plot(ZelenCap.ld, 
       distribution = input$dist2, 
       conf.level = as.numeric(input$ci2), 
       band.type = input$bt2) 
})
  output$mleplot <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$mleplot == "CDF Plot") mleprobplot(ZelenCap.ld, 
                                               distribution = input$mledist, 
                                               conf.level = as.numeric(input$cimle2),
                                               param.loc = input$paramloc) 
  if (input$mleplot == "Hazard Plot") mlehazplot(ZelenCap.ld, 
                                                 distribution = input$mledist,
                                                 conf.level = as.numeric(input$cimle2),
                                                 param.loc = input$paramloc)
  if (input$mleplot == "Compare CDF Plots") 
    compare.mleprobplot(ZelenCap.ld, 
                        main.distribution = input$mledist, 
                        compare.distribution = ifelse(is.null(input$mlecomp),
                                                      'Lognormal', 
                                                      input$mlecomp))
})
  output$altplot <- renderPlot({ 
  par(family = "serif", font = 2)
  if (input$altvar == "Non Constant") groupi.mleprobplot(ZelenCap.ld, 
                                                         distribution = input$altdist,
                                                         group.var = c(1, 2))   
  if (input$altvar == "Constant")     groupm.mleprobplot(ZelenCap.ld, 
                                                         distribution = input$altdist)
})
})
