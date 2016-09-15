library('SMRD')










  
superalloy.ld <- frame.to.ld(SMRD::superalloy,
                             response.column = 1, 
                             censor.column = 2,
                             x.columns = c(4,5,6),
                             time.units = "Kilocycles")

shinyApp(options = list(height = '800px'),
         
ui = navbarPage(theme = shinythemes::shinytheme('flatly'), 
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = T),

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
  
  mainPanel( plotOutput("mleplot")))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
    par(family = "serif", font = 2)
           
  output$summary2 <- renderPrint({ summary(superalloy.ld)                        
})

  output$table2 <- DT::renderDataTable({ DT::datatable(superalloy.ld,
                                                       options = list(pageLength = 8)) 
})

  output$eventplot2 <- renderPlot({ 
  
  if (input$PLOT2 == "Event Plot") event.plot(superalloy.ld) 
  
  if (input$PLOT2 == "Histogram") hist(Response(superalloy.ld), 
                                      probability = TRUE, 
                                      col = 1, 
                                      border = "white", 
                                      main = "", 
                                      xlab = attr(superalloy.ld,"time.units"))
})

  output$cdfplot2 <- renderPlot({ 
  
  plot(superalloy.ld, 
       distribution = input$dist2, 
       conf.level = as.numeric(input$ci2), 
       band.type = input$bt2) 
})
  
output$mleplot <- renderPlot({ 

  if (input$mleplot == "CDF Plot") mleprobplot(superalloy.ld, 
                                               distribution = input$mledist, 
                                               param.loc = input$paramloc ) 
  
  if (input$mleplot == "Hazard Plot") mlehazplot(superalloy.ld, 
                                                 distribution = input$mledist,
                                                 param.loc = input$paramloc) 
})
})
