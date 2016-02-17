distribution_lev <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("lev", label = h2(HTML("<b>Function</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("range.lev", label = h2(HTML("<b>Range</b>")),
              min = -20, max = 20, value = c(-4,4)),
  numericInput("mu.lev", label = h2(HTML("<b>Mean (&mu;)</b>")),
              min = -3, max = 3, step = 0.5, value = 0),
  numericInput("sig.lev", label = h2(HTML("<b>Std Dev (&sigma;)</b>")),
              min = 1, max = 10, step = 0.5, value = 1)),

mainPanel(metricsgraphicsOutput("plotlev", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotlev <- renderMetricsgraphics({

Time<-signif(seq(min(input$range.lev), max(input$range.lev), length = 500),digits = 4)
CDF <- SMRD:::plev(Time,loc=input$mu.lev,scale=input$sig.lev)
PDF <- SMRD:::dlev(Time,loc=input$mu.lev,scale=input$sig.lev)
REL <- 1-CDF
haz <- PDF/REL
HAZ <- -1*log(1-SMRD:::plev(Time,loc=input$mu.lev,scale=input$sig.lev))

lev.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.lev <- switch (input$lev, 
                'CDF' = {
  mjs_plot(lev.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(lev.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(lev.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(lev.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(lev.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.lev
}) 
})
}
