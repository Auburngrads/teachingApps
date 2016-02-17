distribution_exponential <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("e", label = h2(HTML("<b>Function:</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("rangee", label = h2(HTML("<b>Range:</b>")),
              min = 0, max = 50, value = c(0,20)),
  numericInput("theta", label = h2(HTML("<b>Scale (&theta;)</b>")),
              min = .5, max = 10, step = .5, value = 1),
  numericInput("gamma", label = h2(HTML("<b>Location (&gamma;)</b>")),
              min = 0, max = 15, step = 1, value = 0)),

  mainPanel(metricsgraphicsOutput("plotexp", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotexp <- renderMetricsgraphics({
  
Time<-signif(seq(min(input$rangee), max(input$rangee), length = 500),digits = 4)
CDF <- pexp(Time-input$gamma,input$theta)
PDF <- dexp(Time-input$gamma,input$theta)
REL <- 1-CDF
haz <- 1/input$theta
HAZ <- -1*log(1-pexp(Time-input$gamma,input$theta))

exp.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.e <- switch (input$e, 
                'CDF' = {
  mjs_plot(exp.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(exp.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(exp.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(exp.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(exp.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.e
})
})
}
