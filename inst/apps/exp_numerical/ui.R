library(teachingApps)

ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme), 
               tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                 
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                                    wordWrap = T,
                                    outputId = "mlexpnum", 
                                    mode = "r", 
                                    theme = "github", 
                                    height = "500px", 
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

        actionButton("mlexpnums", h4("Evaluate"), width = '100%')),
        
        mainPanel(verbatimTextOutput("mlexp2"), width = 7)),

if(!source('args.R')[[1]]$story) 
     fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))
