library(teachingApps)
library('metricsgraphics')

shinyApp(options = list(height = "700px"),
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Geometric Distribution',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),
                
tabPanel(h4('Shiny App'),
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
                   metricsgraphicsOutput("geomQ", height = "600px")))))), 

tabPanel(h4('Distribution Functions'),
         mainPanel(uiOutput('geofunc'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Distribution Properties'),
         mainPanel(uiOutput('geoprops', class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
geom.t <- reactive({ min(input$range.geom):max(input$range.geom) })
geom.p <- reactive({ signif(seq(0, 1, length = length(max(geom.t()):min(geom.t()))), digits = 4) })
geom.C <- reactive({ pgeom(geom.t(), input$prob.geom)})
geom.P <- reactive({ dgeom(geom.t(), input$prob.geom)})
geom.R <- reactive({ 1 - geom.C()})
geom.h <- reactive({ exp(log(geom.P())-log(geom.R()))})
geom.H <- reactive({ -1 * log(1 - pgeom(geom.t(),input$prob.geom))})
geom.Q <- reactive({ qgeom(geom.p(),input$prob.geom)})
geom.df <- reactive({ data.frame(Time = geom.t(), 
                             PROB = geom.p(), 
                             CDF = geom.C(), 
                             PMF = geom.P(), 
                             REL = geom.R(), 
                             haz = geom.h(), 
                             HAZ = geom.H(),
                             QUANT = geom.Q()
                             )})
 
output$geomC <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = CDF, decimals = 4, top = 0) %>% 
  mjs_point(point_size = 10)                              %>% 
  mjs_labs(x_label = "X = x", y_label = "F(x)")       %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomP <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = PMF, decimals = 4)         %>% 
  mjs_point(point_size = 10)                             %>%
  mjs_labs(x_label = "X = x", y_label = "f(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomR <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = REL, decimals = 4)         %>% 
  mjs_point(point_size = 10)                             %>% 
  mjs_labs(x_label = "X = x", y_label = "S(x)")      %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomh <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = haz, decimals = 4) %>%
  mjs_point(point_size = 10)  %>%
  mjs_labs(x_label = "X = x", y_label = "h(x)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomH <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = Time, y = HAZ, decimals = 4) %>% 
  mjs_point(point_size = 10)  %>% 
  mjs_labs(x_label = "X = x", y_label = "H(x)") %>% 
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geomQ <- renderMetricsgraphics({
  mjs_plot(geom.df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_point(point_size = 10)  %>%
  mjs_labs(x_label = "Probability (p)", y_label = "x(p)") %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")
})
output$geofunc <- renderUI({ 
  withMathJax(HTML(includeMarkdown('geo-func.Rmd')))
})
output$geoprops <- renderUI({HTML(includeMarkdown('geo-props.Rmd'))
}) 
})
