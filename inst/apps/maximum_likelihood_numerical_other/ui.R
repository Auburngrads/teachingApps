ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = add_theme(getShinyOption('theme')), 
               add_css(),
                 
sidebarLayout(
   sidebarPanel(width = 6,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "solnum", 
                          mode = "r", 
                          theme = "github", 
                          height = "530px", 
                          value = 
"set.seed(as.numeric(Sys.Date()))

obs <- runif(2,0.5,4.5)

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

        actionButton("mlsolnum", "Evaluate")),
        
        mainPanel(verbatimTextOutput("mlsolns"), width = 6)))
