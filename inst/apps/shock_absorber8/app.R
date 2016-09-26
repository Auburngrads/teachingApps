library(pos = -1,  package = 'SMRD')











par(family = "serif", font = 2)

ShockAbsorber.ld <- frame.to.ld(SMRD::shockabsorber,
                                response.column = 1, 
                                censor.column = 3, 
                                time.units = "Kilometers")

load('args.Rdata')
shinyApp(options = list(height = '800px', width = '99%'),
         
     ui = navbarPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                     try(includeCSS(system.file('css','my-shiny.css', 
                                                package = 'teachingApps')), silent = TRUE),
                     
tabPanel(h4("Data Set"),   DT::dataTableOutput("table.shock", height = "80%") ),    
tabPanel(h4("Summary"), verbatimTextOutput("summary.shock")), 
tabPanel(h4("Event Plots"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("PLOT_3", 
                  label = h2("Plot Type"),
                  choices = c("Event Plot","Histogram"),
                  selected = "Event Plot")),  
    
mainPanel( plotOutput("eventplot.shock", height = '600px'), width = 9))),

tabPanel(h4("CDF Plot"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("DIST_3", 
                  label = h2("Distribution"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),

      selectInput("CI_3",
                  label = h2("Confidence Level"),
                  choices = c(0.99, 0.95, 0.90, 0.85, 0.80, 0.50), 
                  selected = 0.95),
                   
      selectInput("BT_3",
                  label = h2("Band Type"),
                  choices = c("Pointwise", 
                              "Simultaneous", 
                              "none"),
                  selected = "Pointwise")),  

mainPanel( plotOutput("cdfplot.shock", height = '600px'), width = 9))),

tabPanel(h4("MLE Plot"),
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput("mleplot", 
                  label = h2("Plot Type"),
                  choices = c("CDF Plot",
                             "Hazard Plot", 
                             "Compare CDF Plots"), 
                  selected =  "CDF Plot"),

      selectInput("mledist", 
                  label = h2("Distribution"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                       
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                   selected = "Weibull"),

      selectInput("mlecomp", 
                  label = h2("Compare Distribution"),
                  choices = c("Weibull",
                              "Exponential",
                              "Normal",
                              "Lognormal",                      
                              "Smallest Extreme Value",
                              "Largest Extreme Value",
                              "Frechet"), 
                  selected = "Weibull"),

      selectInput("paramloc", 
                  label = h2("Parameter Location"),
                  choices = c("topleft",
                              "topright",
                              "bottomleft",
                              "bottomright"), 
                  selected = "bottomright")),  
    
mainPanel( plotOutput("mleplot", height = '600px'), width = 9))),

tabPanel(h4('Code Mirror'),
         
mainPanel(codemirrorR::codemirrorOutput('mlemirror', height = '600px'), width = 12)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  

          
output$summary.shock <- 
  renderPrint({ summary(ShockAbsorber.ld) 
})

output$table.shock <-    
  DT::renderDataTable({DT::datatable(ShockAbsorber.ld,
                                   options = list(pageLength = 12)) 
})

output$eventplot.shock <- 
  renderPlot({ 
  if (input$PLOT_3 == "Event Plot") 
    event.plot(ShockAbsorber.ld) 
    
  if (input$PLOT_3 == "Histogram")  
    hist(Response(ShockAbsorber.ld), 
         probability = TRUE, 
         col = 1, 
         border = "white", 
         main = "", 
         xlab = attr(ShockAbsorber.ld,"time.units"))
})

output$cdfplot.shock <- 
  renderPlot({ 
  plot(ShockAbsorber.ld, 
       distribution = input$DIST_3, 
       conf.level = as.numeric(input$CI_3), 
       band.type = input$BT_3) 
})

output$mleplot <- 
  renderPlot({ 
  if (input$mleplot == "CDF Plot") 
    mleprobplot(ShockAbsorber.ld, 
                distribution = input$mledist, 
                param.loc = input$paramloc ) 
    
  if (input$mleplot == "Hazard Plot") 
    mlehazplot(ShockAbsorber.ld, 
               distribution = input$mledist,
               param.loc = input$paramloc)
    
  if (input$mleplot == "Compare CDF Plots") 
    compare.mleprobplot(ShockAbsorber.ld, 
                        main.distribution = input$mledist, 
                        compare.distribution = input$mlecomp) 
})

output$mlemirror <-
  codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r', doc = "
## The only new function in this app is `compare.mleprobplot( )`
## This function is used to compare best-fit members of two or more
## distribution families
##
## The code used in this app to compare distributions is shown below
## Note that the compare.dictribution argument will accept a vector of
## multiple distributions.

ShockAbsorber.ld <- frame.to.ld(SMRD::shockabsorber,
                                response.column = 1, 
                                censor.column = 3,
                                data.title = 'Shock Absorber Data (Both Failure Modes)',
                                time.units = 'Kilometers')

compare.mleprobplot(ShockAbsorber.ld, 
                    main.distribution = 'lognormal', 
                    compare.distribution = c('Weibull'), 
                    band.type = 'pointwise')

                                                         ")
})
})
