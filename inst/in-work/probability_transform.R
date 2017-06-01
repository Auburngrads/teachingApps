cdf <- function(x) {tanh(x)}
pdf <- function(x) {1 - (tanh(x))^2}

#therefor F inverse is atanh(x)

F_inv <- function(x) {atanh(x)}

# so to sample form this new distribution we sample from the uniform and then apply
# F_inv to those samples

# For example

unif <- runif(1000000,0,1)

samp <- F_inv(unif)

hist(samp,
     br = 100,
     xlim = c(0,5), 
     probability = T, 
     col = scales::alpha('blue', 0.25))
curve(pdf(x),
      xlim = c(0,5),
      col = 2, 
      add = T,
      lwd = 2)
