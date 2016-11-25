library(teachingApps)
library(scales)

shinyApp(options = list(height = "700px"),
onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
              tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
      inputPanel(
      selectInput('dist1', h2('Distro 1'), choices = c('Normal'), selected = 'Normal'),
      selectInput('dist2', h2('Distro 2'), choices = c('Normal'), selected = 'Normal')),
      
      fluidRow(
        column(width = 2,
      sliderInput('normal1.1', 
                  label = h2(HTML('Mean - &mu;<sub>1</sub>')), 
                  min = 4,
                  max = 30,
                  step = 1,
                  value = 12),
      sliderInput('normal1.2', 
                  label = h2(HTML('Std Dev - &sigma;<sub>1</sub>')), 
                  min = 1,
                  max = 10,
                  step = .5,
                  value = 4 )),
      
        column(width = 2,
      sliderInput('normal2.1', 
                  label = h2(HTML('<red>Mean - &#x3BC;<sub>2</sub></red>')), 
                  min = 3,
                  max = 30,
                  step = 1,
                  value = 20),
      sliderInput('normal2.2', 
                  label = h2(HTML('<red>Std Dev - &sigma;<sub>2</sub></red>')), 
                  min = 1,
                  max = 10,
                  step = .5,
                  value = 5 )),
    
        column(width = 8, plotOutput('cross', height = '550px'))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName))})
  
output$cross <- renderPlot({
param1 <- c(input$normal1.1,input$normal1.2)
param2 <- c(input$normal2.1,input$normal2.2)
pdf1 <- curve(dnorm(x,param1[1], param1[2]), 
              col = 1, lwd = .3, 
              xlim = qnorm(c(.00001,.9999999),param1[1], param1[2])*1.5,
              n = 300, las = 1)
pdf2 <- curve(dnorm(x,param2[1], param2[2]), 
              add = TRUE,
              col = 'darkgreen' , lwd = .3, n = 300)

dats <- data.frame(pdf1$x, 
                   (pdf1$y*as.numeric(pdf1$y>.001))/(pdf2$y*as.numeric(pdf2$y>.001)))

pts <- which.min(abs(1-(dats[,2])))

polygon(x = pdf2$x[1:length(pdf2$x)],
        y = c(pdf2$y[1:pts],pdf1$y[(pts+1):length(pdf1$y)]), 
        col = alpha('red', .6))

polygon(x = pdf1$x[1:length(pdf1$x)],
        y = c(pdf1$y[1:pts],pdf2$y[(pts+1):length(pdf2$y)]), 
        col = alpha('blue', .3))
})
})
