server = function(input, output, session) {

   session$onFlush(function() teachingApps:::add_css())
  
    output$bayesplot <- renderPlot({ 
      
prior.N = input$nsims
 data.N = input$datasize
    t_c = input$tcensor

gam.shape <- input$gamshape
gam.scale <- input$gamscale
exp.rate  <- 1/input$expmle

# Set up the prior

prior <- rgamma(prior.N, shape = gam.shape, scale = gam.scale)

DATA <- data.frame(hours = rexp(data.N, rate = exp.rate))

DATA[DATA >= t_c] <- t_c

DATA$censor <- sapply(X = seq_along(DATA[,1]),
                      FUN = function(x) `if`(DATA[x,1]==t_c, 0, 1))

DATA.ld <- frame.to.ld(DATA, 
                       response.column = 1, 
                       censor.column = 2)

DATA.mlest <- mlest(DATA.ld, 
                    distribution = 'exponential')

max.ll <- as.numeric(print(DATA.mlest)$ll.v)

keep <- teachingApps:::likely2(times = DATA$hours, 
                cens = DATA$censor,
                params = prior,
                maxll = max.ll)

Prior <- data.frame(vals = prior)
Prior$type <- 'prior'

Posterior <- data.frame(vals = prior[keep])
Posterior$type <- 'posterior'

Prior_Post <- rbind(Prior, Posterior)

ggh = ggplot(Prior_Post, aes(vals, fill = type))
  
ggh + geom_density(alpha = 0.4) + theme_light(base_size = 18)

})
}
