ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),

sidebarLayout(
  sidebarPanel(width = 6,
    shinyAce::aceEditor(fontSize = 16, 
                        wordWrap = T,
                        outputId = "samp", 
                        mode = "r", 
                        theme = "github", 
                        value = "
N <- 100
n <- 10

pop <- rweibull(N, 2.3, 10)
samp <- sample(pop, size = n)

dens_pop  <- density(pop,  from = 0, to = 30)
dens_samp <- density(samp, from = 0, to = 30)

par(xaxs = 'i', yaxs = 'i')
par(ann = F, bty = 'n', lwd = 3)

plot(dens_pop,   col = 4, axes = F)
lines(dens_samp, col = 2)

axis(1, lab = F, at = pop,  tck = -.05, col = 4)
axis(1, lab = F, at = samp, tck =  .05, col = 2)
legend(  x = 'topright', 
       col = c(4,2),
       bty = 'n',
       lwd = 3,
       legend = c(
         paste0('(N = ',N,') Population'),
         paste0('(n = ',n,')   Sample')))"),

        actionButton("sampplot", "Evaluate")),
        
        mainPanel(plotOutput("samps", height = "600px"), width = 6)))
