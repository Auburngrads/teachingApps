distribution_normal <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("n", label = h2(HTML("<b>Function</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("range.n", label =h2(HTML("<b>Range</b>")),
              min = -20, max = 20, value = c(-4,4)),
  numericInput("mu.n", label = h2(HTML("<b>Mean (&mu;)</b>")),
              min = -3, max = 3, step = 0.5, value = 0),
  numericInput("sig.n", label = h2(HTML("<b>Std Dev (&sigma;)</b>")),
              min = 0.5, max = 5, step = 0.5, value = 1 )),

mainPanel(metricsgraphicsOutput("plotnorm", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotnorm <- renderMetricsgraphics({

Time<-signif(seq(min(input$range.n), max(input$range.n), length = 500),digits = 4)
CDF <- pnorm(Time,mean=input$mu.n,sd=input$sig.n)
PDF <- dnorm(Time,mean=input$mu.n,sd=input$sig.n)
REL <- 1-CDF
haz <- PDF/REL
HAZ <- -1*log(1-pnorm(Time,mean=input$mu.n,sd=input$sig.n))

norm.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.norm <- switch (input$n, 
                'CDF' = {
  mjs_plot(norm.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(norm.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(norm.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(norm.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(norm.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.norm
}) 
})
}
