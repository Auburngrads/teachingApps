#Make plot

data = mtcars
response <- data[,1]
model.mat <- as.matrix(data[,-1])

lm.model <- lm(response~model.mat)

summary(lm.model)

#model.eqn <- function(lm.model = NULL) 
  
  lm.coeff  <- lm.model$coeff
  lm.modmat <- model.matrix(model)
  responses <- lm.modmat%*%lm.coeff
  range <- mean(responses) + c(-3,3) * sd(response)
  MSE <- sum(lm.model$residuals^2)/(length(lm.model$fitted.values)-2)
  
  models <- lapply(X = responses,
                   FUN = function(y) dnorm(seq(range[1],range[2], length.out = 100),
                                           mean = y, 
                                           sd = sqrt(MSE)))
  
  plot(x = seq(range[1],range[2], length.out = 100),
       y = models[[1]],
       type = 'l')
  lapply(X = 2:length(models),
         FUN = function(x)lines(x = seq(range[1],range[2], length.out = 100),
                                y = models[[x]]))
  
  matrix(pnorm())
  model$coef, c(NA,colnames(data)[-1]))


line <- function(params,size, mean = 0, sd = 0) {
  
  x <- runif(size, 2,4)
  y <- 3*x + 7 + rnorm(size, mean, sd)
  
  F <- sum((y-params[1]*x - params[2])^2)
  
  return(F) }

Beta <- function(size, mean = 0, sd = 0) {

x <- runif(size, 2,4)
y <- 3*x + 7 + rnorm(size, mean, sd)
  
numer <- sum((x-mean(x))*(y-mean(y)))
denom <- sum((x-mean(x))^2)

beta  <- numer/denom
alpha <- mean(y)-beta*mean(x)

return(c(beta, alpha))
}
