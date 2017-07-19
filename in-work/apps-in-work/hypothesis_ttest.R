# generate sample one data

delta <- 0.5
N = 20

norm <- function(mu = 0, sd = 1, delta = 0.5, N = 20) 
{
  xlim = range(qnorm(c(0.0001, 0.9999), mean = mu,         sd = sd),
               qnorm(c(0.0001, 0.9999), mean = mu + delta, sd = sd))
  
  x  = seq(xlim[1], xlim[2], length.out = 300)
  y1 = dnorm(x, mean = mu,       sd = sd)
  y2 = dnorm(x, mean = mu+delta, sd = sd)
  
  return(list(x = x, 
              y1 = y1, 
              y2 = y2, 
              range = xlim, 
              mu = mu, 
              sd = sd, 
              samp_mu = samp_mu,
              samp_sd = samp_sd,
              samp_se = samp_se))
}

par(lwd = 2, las = 1)

# welches t-test

  Data <- norm()
  pval1 <- round(1-pnorm(Data$samp_mu, mean = Data$mu, sd = Data$sd), digits = 4)
  pval2 <- pt((Data$samp_mu-Data$mu)/Data$samp_se, df = N - 1 )
 plot(x = Data$x, 
      y = Data$y1, 
      col = 1,
      xlim = Data$range, 
      type = 'l',
      yaxs = 'i',
      ylim = c(0,max(Data$y1)*1.1))
 pdf_shade(params = c(Data$mu[1], Data$sd[1]))
lines(Data$x, Data$y2, col = 4)
abline(v = Data$mu + Data$delta, lty = 2, col = 'steelblue')
mtext(side = 3, 
      text = parse(text = paste0('p == ', pval1)),
      at = Data$samp_mu)

pdf_shade <- function(alpha = 0.05, params = c(0, 1), length = 100, col = 'red') {
  
   vals <- seq(1-alpha/2, 1, length.out = length)
  xmids <- qnorm(vals,      params[1], params[2]) 
  xendl <- qnorm(1-alpha/2, params[1], params[2])
  xendh <- qnorm(1-1e-9,    params[1], params[2])
  xfull <- c(xendl, xmids, xendh)
  
  ymids <- dnorm(xmids, params[1], params[2])
  yfull <- c(0,ymids,0)
  
  return(polygon(x = xfull, y =  yfull, 
                 col = scales::alpha(colour = col, 0.25),
                 border = F))
} 

# students t-test
# 
# params <- c(0,1)
# delta = 1
# 
#  curve(dnorm(x, params[1], params[2]), col = 1, type = 'l')
#  pdf_shade(params = c(params[1], params[2]))
#  curve(dnorm(x, params[1]+delta, params[2]), col = 4, add = T)
# lines(Data$x, Data$y2, col = 4)


# Fit the distribution

library(fitdistrplus)

samp <- rnorm(20, mean = Data$mu+Data$delta, sd = Data$sd)

fitdist(samp, distr = 'norm')

samp <- rnorm(N, mu + delta, sd)
  samp_mu <- mean(samp)
  samp_sd <- sd(samp)
  samp_se <- samp_sd/sqrt(N)
