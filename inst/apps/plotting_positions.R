plotting_positions <- function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(height = '600px'),

ui = fluidPage(theme = shinythemes::shinytheme('flatly'),
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
     sidebarLayout(
      sidebarPanel(
        sliderInput("plotposn", 
                    label = h2("Sample Size"), 
                    min = 5, 
                    max = 100, 
                    value = 5, 
                    step = 5),
        hr(),
        checkboxGroupInput("plotpos",
                           label = h2("Plotting Position"), 
                           choices = c("Hazen" = 1,
                                       "Median-Ranks" = 2,
                                       "Weibull"      = 3),
                           selected = NULL, 
                           inline = FALSE,
                           width = validateCssUnit("1000")),
        hr(),
        actionButton("takeSample.pp",h2("Sample Data"), width = '100%')),
      
        mainPanel(plotOutput("probplotcompare", height = '600px')))),

server = function(input,output, session) {
     
rv1 <- reactiveValues( data.mat = NULL )

observeEvent(input$takeSample.pp, {

  data<-rweibull(input$plotposn, shape = 1.25, scale = 10)
  orig.dat<-sort(data)
  rank.dat<-rank(orig.dat)
  pp.1<-function(a) {(cumsum(rank.dat/rank.dat)-a)/(length(rank.dat)+1-2*a)}
  pp.2<-(cumsum(rank.dat/rank.dat))/(length(rank.dat))
  rv1$data.mat<-matrix(NA, ncol = 5, nrow = length(data), byrow = FALSE)
  rv1$data.mat[,1]<-orig.dat
  rv1$data.mat[,2]<-log(log(1/(1-pp.2)))
  rv1$data.mat[,3]<-log(log(1/(1-pp.1(0.5))))
  rv1$data.mat[,4]<-log(log(1/(1-pp.1(0.3))))
  rv1$data.mat[,5]<-log(log(1/(1-pp.1(0.0))))
  colnames(rv1$data.mat)<-c("Data","N-P","Hazen","M-R","Weib")
  
})

leg<-c(NA,NA,NA)
pch<-c(NA,NA,NA)
col<-c(NA,NA,NA)

output$probplotcompare <- renderPlot({

par(family = "serif", bg = NA, mar = c(4.1,4.25,0.1,2.1))
plot(NA, log = "x", xlab = expression(t[p]), 
       ylab = expression(Phi[SEV]*" "*(t[p])), ylim = c(-5,2),xlim = c(1,30))
points(rv1$data.mat[,1],rv1$data.mat[,2], pch = 16)
if (1%in%input$plotpos) {points(rv1$data.mat[,1],rv1$data.mat[,3], pch = 16, col = 2)}
if (2%in%input$plotpos) {points(rv1$data.mat[,1],rv1$data.mat[,4], pch = 16, col = "green")}
if (3%in%input$plotpos) {points(rv1$data.mat[,1],rv1$data.mat[,5], pch = 16, col = "blue")}

legend("topleft", legend = leg, bg = NA, bty = "n", pch = pch,col = col)

})
})
}