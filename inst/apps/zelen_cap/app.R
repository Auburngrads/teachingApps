library( package = 'SMRD')

ZelenCap.ld <- frame.to.ld(SMRD::zelencap, 
                           response.column = 1, 
                           censor.column = 2, 
                           case.weight.column = 3,
                           x.columns = c(4, 5),
                           time.units = "Hours", 
                           xlabel = c(expression(C^o), expression("Volts")))

shinyApp(options = list(width = "100%", height = "625px"),

ui = navbarPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),

    tabPanel(h2("Data Set"), DT::dataTableOutput("table2", height = "565px") ),    
    tabPanel(h2("Summary"),  verbatimTextOutput("summary2") ), 

    tabPanel(h2("Event Plots"),
      sidebarLayout(
      sidebarPanel(
        
      selectInput("PLOT2", 
                  label = h4("Plot Type:"),
                  choices = c("Event Plot",
                              "Histogram"),
                  selected = "Event Plot")),  
      
      mainPanel( plotOutput("eventplot2", height = "565px")))),

    tabPanel(h2("CDF Plot"),
      sidebarLayout(
      sidebarPanel(
        
        selectInput("dist2", 
                    label = h4("Distribution:"),
                    choices = c("Weibull",
                                "Exponential",
                                "Normal",
                                "Lognormal",                                                
                                "Smallest Extreme Value",
                                "Largest Extreme Value",
                                "Frechet"), 
                    selected = "Weibull"),
        
        selectInput("ci2",   
                    label = h4("Confidence Level:"),
                    choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                    selected = 0.95),
        
        selectInput("bt2",   
                    label = h4("Band Type:"),
                    choices = c("Pointwise", 
                                "Simultaneous", 
                                "none"), 
                    selected = "Pointwise")), 
      
      mainPanel( plotOutput("cdfplot2",height = "565px")))),
    
  tabPanel(h2("MLE Plot"),
    sidebarLayout(
    sidebarPanel(
      selectInput("mleplot", 
                  label = h4("Plot Type:"),
                  choices = c("CDF Plot",
                              "Hazard Plot"), 
                  selected = "CDF Plot"),
      
      selectInput("mledist", 
                  label = h4("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                                                
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),
      
      selectInput("paramloc", 
                  label = h4("Parameter Location:"),
                  choices = c("topleft",
                              "topright",
                              "bottomleft",
                              "bottomright"), 
                  selected = "bottomright")),
    
    mainPanel( plotOutput("mleplot",height = "565px")))),

  tabPanel(h2("ALT Plot"),
    sidebarLayout(
    sidebarPanel(
      selectInput("altvar", 
                  label = h4("Variance:"),
                  choices = c("Non Constant",
                              "Constant"), 
                  selected = "Non Constant"),
      
      selectInput("altdist", 
                  label = h4("Distribution:"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                                                
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull")),
    
    mainPanel( plotOutput("altplot",height = "565px")))), 
  
fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
         
  output$summary2 <- renderPrint({ summary(ZelenCap.ld)})

  output$table2 <- DT::renderDataTable({ DT::datatable(ZelenCap.ld,
                                                       options = list(pageLength = 10)) })

  output$eventplot2 <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    if (input$PLOT2 == "Event Plot") event.plot(ZelenCap.ld) 
    if (input$PLOT2 == "Histogram")  hist(Response(ZelenCap.ld), 
                                      probability = TRUE, col = 1, 
                                      border = "white", main = "", 
                                      xlab = attr(ZelenCap.ld,"time.units"))})

  output$cdfplot2 <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    plot(ZelenCap.ld, distribution = input$dist2, 
     conf.level = as.numeric(input$ci2), band.type = input$bt2) })
  
  output$mleplot <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    if (input$mleplot == "CDF Plot") mleprobplot(ZelenCap.ld, 
                                                 distribution = input$mledist, 
                                                 param.loc = input$paramloc ) 
    if (input$mleplot == "Hazard Plot") mlehazplot(ZelenCap.ld, 
                                                   distribution = input$mledist,
                                                   param.loc = input$paramloc)})

  output$altplot <- renderPlot({ 
    par(family = "serif",bg = NA, font = 2)
    if (input$altvar == "Non Constant") groupi.mleprobplot(ZelenCap.ld, 
                                                           distribution = input$altdist, 
                                                           group.var = c(1, 2))
    
    if (input$altvar == "Constant")     groupm.mleprobplot(ZelenCap.ld, 
                                                           distribution = input$altdist)
})
})
