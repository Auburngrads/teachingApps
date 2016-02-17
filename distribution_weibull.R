distribution_weibull <-
function(...) {
  
  library(shiny)
  library(metricsgraphics)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("w", label = h2(HTML("<b>Function</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), selected = "CDF"),
  
sliderInput("range.w", label = h2(HTML("<b>Range</b>")),  min = 0, max = 50, value = c(0,25)),
numericInput("scale.w", label = h2(HTML("<b>Scale (&eta;)</b>")),  
            min = 5, max = 30, step = 1, value = 10),
numericInput("shape.w", label = h2(HTML("<b>Shape (&beta;)</b>")),  
            min = .5, max = 10, step = .5, value = .5)),

mainPanel(metricsgraphicsOutput("plotweib", height = "600px"),width = 9))),

server = function(input,output,session) {
  
output$plotweib <- renderMetricsgraphics({

weibhaz <-function(x,sc, sh) {sh/sc*(x/sc)^(sh-1)}
Time<-signif(seq(min(input$range.w), max(input$range.w), length = 500),digits = 4)
CDF <- pweibull(Time,sc=input$scale.w,sh=input$shape.w)
PDF <- dweibull(Time,sc=input$scale.w,sh=input$shape.w)
REL <- 1-CDF
haz <- weibhaz(Time, sc=input$scale.w,sh=input$shape.w)
HAZ <- -1*log(1-pweibull(Time,sc=input$scale.w,sh=input$shape.w))

weib.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.w <- switch (input$w, 
                'CDF' = {
  mjs_plot(weib.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(weib.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(weib.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(weib.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(weib.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.w 
})
})
}
