distribution_logistic <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("l", label = h2(HTML("<b>Function</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("range.l", label = h2(HTML("<b>Range</b>")),
              min = -20, max = 20, value = c(-4,4)),
  numericInput("mu.l", label = h2(HTML("<b>Mean (&mu;)</b>")),
              min = -3, max = 3, step = 0.5, value = 0),
  numericInput("sig.l", label = h2(HTML("<b>Std Dev (&sigma;)</b>")),
              min = 0.5, max = 5, step = 0.5, value = 1)),

mainPanel(metricsgraphicsOutput("plotlog", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotlog <- renderMetricsgraphics({

Time<-signif(seq(min(input$range.l), max(input$range.l), length = 500),digits = 4)
CDF <- plogis(Time,loc=input$mu.l,scale=input$sig.l)
PDF <- dlogis(Time,loc=input$mu.l,scale=input$sig.l)
REL <- 1-CDF
haz <- PDF/REL
HAZ <- -1*log(1-plogis(Time,loc=input$mu.l,scale=input$sig.l))

log.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.log <- switch (input$l, 
                'CDF' = {
  mjs_plot(log.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(log.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(log.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(log.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(log.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.log 
})
})
}
