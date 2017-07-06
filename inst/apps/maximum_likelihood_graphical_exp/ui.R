ui = fluidPage(titlePanel('To change the plot update the code and click "Evaluate" '),
               theme = add_theme(getShinyOption('theme')), 
               add_css(),

                 
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

set.seed(as.numeric(Sys.Date()))

obs <- runif(2,0.5,4.5)

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

        actionButton("mlexpplots", "Evaluate")),
        
        mainPanel(plotOutput("mlexp", height = "600px"), width = 7)))



