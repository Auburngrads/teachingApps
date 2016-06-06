distribution_norgets <-
function(...) {
  
  try(attachNamespace('shiny'), silent = TRUE)
  try(attachNamespace('SMRD'), silent = TRUE)
  try(attachNamespace('metricsgraphics'), silent = TRUE)
  
shinyApp(options = list(width = "100%", height = "700px"),
         
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
               try(includeCSS(system.file('css',
                                          'my-shiny.css',
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3,hr(),
  
  sliderInput("range.nget", 
              label = h2("Range"),
              min = 0, 
              max = 20, 
              value = c(0,4)),
  sliderInput("al.nget", 
              label = h2(HTML("&alpha;")),
              min =  0, 
              max =  3, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("si.nget", 
              label = h2(HTML("&sigma;")),
              min = -5, 
              max =  5, 
              step = 0.5, 
              value = 0, 
              animate = TRUE),
  sliderInput("xi.nget", 
              label = h2(HTML("&xi;")),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE)),

  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("ngetC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("ngetP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("ngetR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("ngeth",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("ngetH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("ngetQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApp('distribution_norgets'))})
  
t <-  reactive({ signif(seq(input$range.nget[1], input$range.nget[2],length = 500), digits = 4) })
p <-  reactive({ signif(seq(0, 1, length = 500), digits = 4)  })
C <-  reactive({ pgets(t(),input$al.nget,input$si.nget,input$xi.nget,distribution = "normal") })
P <-  reactive({ dgets(t(),input$al.nget,input$si.nget,input$xi.nget,distribution = "normal")})
R <-  reactive({ 1-C()})
h <-  reactive({exp(log(P())-log(R()))})
H <-  reactive({ -1*log(1-pgets(t(),input$al.nget,input$si.nget,input$xi.nget,distribution = "normal"))})
Q <-  reactive({ qgets(p(),input$al.nget,input$si.nget,input$xi.nget,distribution = "normal")})
df <- reactive({data.frame(Time = t(),PROB = p(), CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$ngetC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$ngetP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$ngetR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$ngeth <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$ngetH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$ngetQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
}
