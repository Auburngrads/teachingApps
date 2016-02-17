distribution_loglogistic <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("ll", label = h2(HTML("<b>Function</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("range.ll", label = h2(HTML("<b>Range</b>")),
              min = 0, max = 50, value = c(0,20)),
  numericInput("mu.ll", label = h2(HTML("<b>Mean (&mu;)</b>")),
              min = 0.5, max = 10, step = 0.5, value = 0.5),
  numericInput("sig.ll", label = h2(HTML("<b>Std Dev (&sigma;)</b>")),
              min = 0.5, max = 10, step = 0.5, value = 1)),

mainPanel(metricsgraphicsOutput("plotllog", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotllog <- renderMetricsgraphics({

Time<-signif(seq(min(input$range.ll), max(input$range.ll), length = 500),digits = 4)
CDF <- pllogis(Time,sc=input$sig.ll,sh=input$mu.ll)
PDF <- dllogis(Time,sc=input$sig.ll,sh=input$mu.ll)
REL <- 1-CDF
haz <- PDF/REL
HAZ <- -1*log(1-pllogis(Time,sc=input$mu.ll,sh=input$sig.ll))

llog.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.llog <- switch (input$ll, 
                'CDF' = {
  mjs_plot(llog.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(llog.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(llog.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(llog.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(llog.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.llog
})
})
}
