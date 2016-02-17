distribution_sev <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("sev", label = h2(HTML("<b>Function</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("range.s", label = h2(HTML("<b>Range</b>")),
              min = -20, max = 20, value = c(-4,4)),
  numericInput("mu.sev", label = h2(HTML("<b>Mean (&mu;)</b>")),
              min = -3, max = 3, step = 0.5, value = 0),
  numericInput("sig.sev", label = h2(HTML("<b>Std Dev (&sigma;)</b>")),
              min = 1, max = 10, step = 0.5, value = 1)),

mainPanel(metricsgraphicsOutput("plotsev", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotsev <- renderMetricsgraphics({

Time<-signif(seq(min(input$range.s), max(input$range.s), length = 500),digits = 4)
CDF <- pgumbel(Time,loc=input$mu.sev,scale=input$sig.sev)
PDF <- dgumbel(Time,loc=input$mu.sev,scale=input$sig.sev)
REL <- 1-CDF
haz <- PDF/REL
HAZ <- -1*log(1-pgumbel(Time, loc=input$mu.sev,scale=input$sig.sev))

sev.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.sev <- switch (input$sev, 
                'CDF' = {
  mjs_plot(sev.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(sev.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(sev.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(sev.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(sev.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.sev 
}) 
})
}
