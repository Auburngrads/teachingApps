library(teachingApps)
library(package = 'SMRD')

shinyApp(options = list(width = "100%", height = "800px"), 
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Example 7.1',
                theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName)),
                
tabPanel(h4('Background'),
         mainPanel(uiOutput('example7.1'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Data"), DT::dataTableOutput("berkson", height = "600px")),

navbarMenu(h4('Figures'), icon = icon('bar-chart-o'),
tabPanel(h4("Figure 7.1"),
fluidRow(column(width = 5,
    sidebarPanel(width = '100%',
      shinyAce::aceEditor(fontSize = 16,
                          wordWrap = T,
                          outputId = "fig71plot",
                          mode = "r",
                          theme = "github",
                          height = "450px",
                          value = "
sample.size <- 20

berkson <- 
switch(as.character(sample.size), 
      '20' = {SMRD::berkson20},
     '200' = {SMRD::berkson200},
    '2000' = {SMRD::berkson2000},
   '10220' = {SMRD::berkson10220})

berkson.ld <- 
frame.to.ld(berkson,
            response.column = c(1,2),
            censor.column = 3,
            case.weight.column = 4)

plot(berkson.ld, distribution = 'Exponential')"),

        actionButton("evalfig71", h4("Evaluate"), width = '100%'))),

column(width = 7, 
       mainPanel(width = '100%',plotOutput("plotfig71", height = "600px"))))))),

server = function(input, output, session) {
  
output$example7.1 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})
output$berkson <- DT::renderDataTable({ 
  
L <- c(0,100,300,500,700,1000,2000,4000)
U <- c(100,300,500,700,1000,2000,4000,'Inf')
n.10220 <- c(1609, 2424,1770,1306,1213,1528,354,16)
n.2000 <- c(292,494,332,236,261,308,73,4)
n.200 <- c(41,44,24,32,29,21,9,0)
n.20 <- c(3,7,4,1,3,2,0,0)
table.7.1 <- data.frame(L,U,n.10220,n.2000,n.200,n.20)

colnames(table.7.1) <- c("Lower","Upper","n = 10220","n = 2000","n = 200","n = 20")

DT::datatable(table.7.1, options = list(pageLength = 10))
})
output$plotfig71 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig71
      return(isolate(eval(parse(text=input$fig71plot))))
})
})