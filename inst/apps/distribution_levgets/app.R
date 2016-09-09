#teachingApps::getPackage('SMRD')
#teachingApps::getPackage('metricsgraphics')









  
shinyApp(options = list(width = "100%", height = "700px"),
         
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),
               try(includeCSS(system.file('css',
                                          'my-shiny.css',
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3,hr(),
  
  sliderInput("range.lget", 
              label = h2("Range"),
              min = 0, 
              max = 20, 
              value = c(0,4)),
  sliderInput("al.lget", 
              label = h2(HTML("&alpha;")),
              min =  0, 
              max =  3, 
              step = 0.5, 
              value = 1, 
              animate = TRUE),
  sliderInput("si.lget", 
              label = h2(HTML("&sigma;")),
              min = -5, 
              max =  5, 
              step = 0.5, 
              value = 0, 
              animate = TRUE),
  sliderInput("xi.lget", 
              label = h2(HTML("&xi;")),
              min = .5, 
              max = 10, 
              step = 0.5, 
              value = 1, 
              animate = TRUE)),

  mainPanel(width = 9,
 tabsetPanel(type = 'pills',
  tabPanel(h4('Distribution Function'),metricsgraphicsOutput("lgetC",height = "600px")),
  tabPanel(h4('Density'),              metricsgraphicsOutput("lgetP",height = "600px")),
  tabPanel(h4('Survival'),             metricsgraphicsOutput("lgetR",height = "600px")),
  tabPanel(h4('Hazard'),               metricsgraphicsOutput("lgeth",height = "600px")),
  tabPanel(h4('Cumulative Hazard'),    metricsgraphicsOutput("lgetH",height = "600px")),
  tabPanel(h4('Quantile'),             metricsgraphicsOutput("lgetQ",height = "600px"))
  ))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
t <-  reactive({ signif(seq(input$range.lget[1], input$range.lget[2],length = 500), digits = 4) })
p <-  reactive({ signif(seq(0, 1, length = 500), digits = 4)  })
C <-  reactive({ pgets(t(),input$al.lget,input$si.lget,input$xi.lget,distribution = "lev") })
P <-  reactive({ dgets(t(),input$al.lget,input$si.lget,input$xi.lget,distribution = "lev")})
R <-  reactive({ 1-C()})
h <-  reactive({exp(log(P())-log(R()))})
H <-  reactive({ -1*log(1-pgets(t(),input$al.lget,input$si.lget,input$xi.lget,distribution = "lev"))})
Q <-  reactive({ qgets(p(),input$al.lget,input$si.lget,input$xi.lget,distribution = "lev")})
df <- reactive({data.frame(Time = t(),PROB = p(), CDF = C(),PDF = P(),REL = R(),haz = h(),HAZ = H(), QUANT = Q())})

  output$lgetC <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = CDF, decimals = 4, top = 0) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'F(t)')%>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")}) 
  
  output$lgetP <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = PDF, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'f(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lgetR <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = REL, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'S(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lgeth <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = haz, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'h(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lgetH <- renderMetricsgraphics({
  mjs_plot(df(), x = Time, y = HAZ, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Time (t)', y_label = 'H(t)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
  
  output$lgetQ <- renderMetricsgraphics({
  mjs_plot(df(), x = PROB, y = QUANT, decimals = 4) %>%
  mjs_line(area = TRUE) %>%
  mjs_labs(x_label = 'Probability (p)', y_label = 't(p)') %>%
  mjs_add_css_rule("{{ID}} .mg-active-datapoint { font-size: 20pt }")})
})
