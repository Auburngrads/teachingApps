ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = add_theme(getShinyOption('theme')), 
               add_css(),

                 
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "mlexpnum", 
                          mode = "r", 
                          theme = "github", 
                          value = 
"set.seed(as.numeric(Sys.Date()))

obs <- runif(2,0.5,4.5)

joint.exp <- function(x, param) { 
  
  Fun <- prod(dexp(x[1:length(x)],1/param))
  
  return(-Fun)   }

nlminb(start = 4, 
       objective = joint.exp, 
       x = obs)[1:5]

# $par shows that the value of theta at which
##  the likelihood function is maximized

## $objective shows the value of the 
## likelihood function when theta = $par 

## Why is $objective negative?"),

        actionButton("mlexpnums", "Evaluate")),
        
        mainPanel(verbatimTextOutput("mlexp2"), width = 7)))
