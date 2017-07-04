server = function(input, output, session) {

    output$bayesplot <- renderPlot({ 
      
prior.N = input$nsims
 data.N = input$datasize
    t_c = input$tcensor

gam.shape <- input$gamshape
gam.scale <- input$gamscale
exp.rate  <- 1/input$expmle

# Set up the prior

prior <- rgamma(prior.N, shape = gam.shape, scale = gam.scale)

obs <- sort(rexp(data.N, rate = exp.rate))

DATA <- data.frame(right = obs)

DATA[DATA >= t_c] <- NA
DATA$left <- obs
DATA[DATA >= t_c] <- t_c

fdc <- fitdistcens(DATA,distr = 'exp')

censor <- sapply(X = seq_along(DATA$left),
                 FUN = function(x) `if`(DATA$left[x]==t_c, 0, 1))

keep <- teachingApps:::likely2(times = DATA$left, 
                cens = censor,
                params = prior,
                maxll = fdc$loglik)

Prior <- data.frame(vals = prior)
Prior$type <- 'prior'

Posterior <- data.frame(vals = prior[keep])
Posterior$type <- 'posterior'

Prior_Post <- rbind(Prior, Posterior)

ggh = ggplot(Prior_Post, aes(vals, fill = type))
  
ggh + geom_density(alpha = 0.4) + theme_light(base_size = 18)

})
}
