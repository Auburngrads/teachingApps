distribution_lognormal <-
function(...) {

  library(shiny)
  library(metricsgraphics
          )
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),"",
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("ln", label = h2(HTML("<b>Function:</b>")),
              choices = c("CDF","PDF","Survival","Hazard","Cum Hazard"), 
  selected = "CDF"),
  
  sliderInput("range.ln", label = h2(HTML("<b>Range:</b>")),
              min = 0, max = 50, value = c(0,20)),
  numericInput("mu.ln", label = h2(HTML("<b>Log[Mean] (ln[&mu;])</b>")),
              min = 0, max = 10, step = 0.5, value = 4),
  numericInput("sig.ln", label = h2(HTML("<b>log[Std Dev] (ln[&sigma;])</b>")),
              min = .5, max = 10, step = 0.5, value = 1)),

mainPanel(metricsgraphicsOutput("plotlnorm", height = "600px"),width = 9))),

server = function(input, output, session) {
  
output$plotlnorm <- renderMetricsgraphics({

Time<-signif(seq(min(input$range.ln), max(input$range.ln), length = 500),digits = 4)
CDF <- plnorm(Time,meanlog=input$mu.ln,sdlog=input$sig.ln)
PDF <- dlnorm(Time,meanlog=input$mu.ln,sdlog=input$sig.ln)
REL <- 1-CDF
haz <- PDF/REL
HAZ <- -1*log(1-plnorm(Time, meanlog=input$mu.ln,sdlog=input$sig.ln))

lnorm.df <- data.frame(Time, CDF, PDF, REL, haz, HAZ)
PLOT.lnorm <- switch (input$ln, 
                'CDF' = {
  mjs_plot(lnorm.df, x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'F(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")},
  
                'PDF' = {
  mjs_plot(lnorm.df, x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'f(t)') },
  
                'Survival' = {
  mjs_plot(lnorm.df, x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'S(t)')},
  
                'Hazard' = {
  mjs_plot(lnorm.df, x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'h(t)') },
  
                'Cum Hazard' = {
  mjs_plot(lnorm.df, x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time', y_label = 'H(t)') }) ; PLOT.lnorm 
})
})
}
