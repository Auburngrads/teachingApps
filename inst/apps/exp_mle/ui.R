library(teachingApps)

ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = shinythemes::shinytheme(theme = global$theme), 
               tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                 
sidebarLayout(
   sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                            wordWrap = T,
                            outputId = "mlexpplot", 
                            mode = "r", 
                            theme = "github",
                            height = "450px", 
                            value = 
"par(font = 2, mar = c(4,5.5,1,1), family = 'serif', cex = 1.5)

obs <- c(4.2564, 0.5319)

theta <- seq(0.25, 10, .05)

joint.prob.exp <- dexp(obs[1], rate = 1/theta)*
                  dexp(obs[2], rate = 1/theta)

plot(theta, joint.prob.exp, 
     xlab = expression(widehat(theta)),
     ylab = expression(prod(t[i],i=1,2)),
     type = 'l', 
     las = 1, 
     lwd = 3, 
     col = 2)

abline(v = sum(obs)/2, lwd = 2, lty = 2)

text(x = sum(obs)/2, 
     y = .005,
     labels = parse(text = paste(c(expression('' %<-% ''), 
                                   sum(obs)/2), 
                                 collapse = '~')),
     adj = 0)"),

        actionButton("mlexpplots", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("mlexp", height = "600px"), width = 7)),

if(!global$story) 
     fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px'))



