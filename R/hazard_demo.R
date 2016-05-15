hazard_demo <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  
shinyApp(options = list(width = "99%", height = "700px"),
ui = navbarPage(theme = shinythemes::shinytheme("flatly"), try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),

tabPanel(h4("Hazard Function Plot"),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("hazplot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "par(family='serif',mar = c(4,6,2,1))

curve(
dlnorm(x, meanlog = log(1.25), sdlog = 1)/
(1-plnorm(x, meanlog = log(1.25), sdlog = 1)),
xlab = 'Time, t',
ylab = expression(h(t)[Log-Normal]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 4,
col = 5,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
              actionButton("evalhaz", h4("Evaluate"))),
        
        mainPanel(plotOutput("plothaz", height = "600px")))),

tabPanel(h4("Bathtub-Shaped Hazard Plot"),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("figbtplot", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2)
NMWPdf<-function(t){
(.071*.595*t^(.595-1)+
7.015*10^-8*(.016+.197*t)*
t^(.016-1)*
exp(.197*t))*
(exp(-1*(.071*t^.595+7.015*10^-8*t^.016*exp(.197*t))))}

curve(NMWPdf,from = 0.0002,to = 83,n = 1000, 
xlab = 't', 
ylab = 'h(t)',
lwd = 3, 
ylim = c(0,0.05), 
las = 1, 
cex.lab = 1.5,
cex.axis = 1.5)
segments(x0 = c(18,63),
         y0 = c(0,0),
         x1 = c(18,63),
         y1 = c(.03,.03),lty=2)
box(lwd=1.25)
text(x = c(7.5, 40, 75),
     y = rep(.001, 3),
     c('Infant Mortality','Useful Life','Wearout'),
     cex = 1.5)"),
              actionButton("evalfigbt", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfigbt", height = "600px"))))),

server = function(input, output, session) {

output$plothaz <- renderPlot({
      input$evalhaz
      return(isolate(eval(parse(text=input$hazplot))))
})
output$plotfigbt <- renderPlot({
      input$evalfigbt
      return(isolate(eval(parse(text=input$figbtplot))))
})
})
}
