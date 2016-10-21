library(teachingApps)
library( package = "metricsgraphics")










  


shinyApp(options = list(height = "700px"), 
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme), 
               try(includeCSS(system.file("css", 
                                          "my-shiny.css", 
                                          package = "teachingApps")), silent = TRUE), 
sidebarLayout(
  sidebarPanel(width = 3, 
hr(), 
sliderInput("range.geom", 
            label = h2("Range"),
            min = 0, 
            max = 50, 
            step = 1,
            value = c(0,10)),
hr(), 
sliderInput("prob.geom", 
            label = h2("Probability"),
            min = .05, 
            max = 1, 
            step=.05, 
            value = .05,
            animate=TRUE)), 

mainPanel(width = 9, 
          tabsetPanel(type = "pills", 
          tabPanel(h4("Distribution Function"), 
                   metricsgraphicsOutput("geomC", height = "600px")), 
          tabPanel(h4("Mass"),
                   metricsgraphicsOutput("geomP", height = "600px")), 
          tabPanel(h4("Survival"), 
                   metricsgraphicsOutput("geomR", height = "600px")), 
          tabPanel(h4("Hazard"), 
                   metricsgraphicsOutput("geomh", height = "600px")), 
          tabPanel(h4("Cumulative Hazard"), 
                   metricsgraphicsOutput("geomH", height = "600px")),
          tabPanel(h4("Quantile"), 
                   metricsgraphicsOutput("geomQ", height = "600px")))
)), 

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {

  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
  
  t <- reactive({ min(input$range.geom):max(input$range.geom) })
  p <- reactive({ signif(seq(0, 1, length = length(max(t()):min(t()))), digits = 4) })
  C <- reactive({ pgeom(t(), input$prob.geom)})
  P <- reactive({ dgeom(t(), input$prob.geom)})
  R <- reactive({ 1 - C()})
  h <- reactive({ exp(log(P())-log(R()))})
  H <- reactive({ -1 * log(1 - pgeom(t(),input$prob.geom))})
  Q <- reactive({ qgeom(p(),input$prob.geom)})
 df <- reactive({ data.frame(Time = t(), 
                             PROB = p(), 
                             CDF = C(), 
                             PMF = P(), 
                             REL = R(), 
                             haz = h(), 
                             HAZ = H(),
                             QUANT = Q()
                             )})
 
      output$geomC <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
          mjs_point(point_size = 10)                              %>% 
          mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomP <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = PMF, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>%
          mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomR <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = REL, decimals = 4)         %>% 
          mjs_point(point_size = 10)                             %>% 
          mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomh <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomH <- renderMetricsgraphics({
        mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>% 
          mjs_point(point_size = 10)  %>% 
          mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
      })
      output$geomQ <- renderMetricsgraphics({
        mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
          mjs_point(point_size = 10)  %>%
          mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
          mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
})
