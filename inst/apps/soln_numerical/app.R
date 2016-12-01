library(teachingApps)

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
    
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Numerical MLE Solution',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),
                
       tabPanel(h4('Numerical Solution'),
        sidebarLayout(
          sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "solnum", 
                                mode = "r", 
                                theme = "github", 
                                height = "530px", 
                                value = 
"obs <- c(4.2564, 0.5319)

model <- 'normal'

distro <- 
switch(tolower(model), 
'norm'  =, 'nor'  =, 'normal'    = 'dnorm',
'lnorm' =, 'lnor' =, 'lognormal' = 'dlnorm',
           'weib' =, 'weibull'   = 'dweibull')

joint.prob <- function(x,param) { 

Fun <- 
paste(c('prod(',
        distro,
        '(x[1:length(x)], param[1], param[2]))'), 
      collapse = '')
  
  return(-eval(parse(text = Fun)))  }

nlminb(start = runif(2, 1.5, 4.2), 
       objective = joint.prob, 
       x = obs)[1:5]"),

        actionButton("mlsolnum", h4("Evaluate"), width = '100%')),
        
        mainPanel(verbatimTextOutput("mlsolns"), width = 7))),

tabPanel(h4('Graphical Solution'),
        sidebarLayout(
          sidebarPanel(width = 5,
            shinyAce::aceEditor(fontSize = 16, 
                                wordWrap = T,
                                outputId = "solplot", 
                                mode = "r", 
                                theme = "github", 
                                height = "450px", 
                                value = 
"par(mar = c(1,0,0.5,2), cex = 1.25)

obs <- c(4.2564, 0.5319)

library(SMRD)

model <- 'weibull'

obs.ld <- frame.to.ld(data.frame(obs), 
                      response.column = 1)

simple.contour(obs.ld, 
               distribution = model, 
               do.persp = T,
               factor = 2)"),

actionButton("mlsolplot", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("mlplots", height = '600px'), width = 7))),

tabPanel(h4('How To Use This App'),

        mainPanel(uiOutput("howto1", class = 'shiny-text-output'), width = 12))),

server = function(input, output, session) {
  
  output$mlsolns <- renderPrint({
      input$mlsolnum
      return(isolate(eval(parse(text=input$solnum))))
})
  
  output$mlplots <- renderPlot({
      input$mlsolplot
      return(isolate(eval(parse(text=input$solplot))))
})
output$howto1 <- renderUI({HTML(
"<h1>There&#39s alot going on in this app, let&#39s go through it <red>item by item</red></h1>

<hr>

<ol><li><code>model <- 'normal'</code> - To change the model used, just type in the name of the distribution and click 'Evaluate'</li>

<li><code>switch( )</code> - This is a handy function to automatically change the way a function performs without needing a bunch of <code>if</code> statements</li>

<li><code>tolower(model)</code> - This function brings all of the letters to lower case - to ensure there&#39s no difference between 'weibull', 'Weibull', or 'WeIbUlL'</li>

<li><code>paste( )</code> - This is an absolutely great function for pasting text and values together - use it all the time</li>

<li><code>start = runif(2, 1.5, 4.2)</code> - All of these distributions have two parameters, so I have to provide <code>nlminb()</code> with two starting values.  This line randomly selects two starting points from a UNIF(1.5, 4.2) distribution.  Note: <code>nlminb()</code> will randomly fail for some starting values</li><ol>")
})
})
