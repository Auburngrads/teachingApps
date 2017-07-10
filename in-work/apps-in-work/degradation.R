
# Install package 'prada' from the Biocondictor repo 
source("https://bioconductor.org/biocLite.R")
biocLite("prada")
library(prada)

# Install mvtnorm package from the CRAN
install.packages('mvtnorm')
library(mvtnorm)

Mean <- c(5.17, 3.73)
Sigma <- matrix(c(2.51,-0.194, -0.194, 0.519), nrow = 2, byrow = T)
binorm <- rmvnorm(100, mean = Mean, sigma = Sigma)

nfit <- prada::fitNorm2(x = binorm[,1], y = binorm[,2], scalefac = 2)

prada::plotNorm2(nfit, selection=TRUE, ellipse=TRUE)



alloyFail <- function(a_0 = NULL, mean, sigma, stress) {
  
  Sigma <- as.matrix(sigma)
  
  if(length(dim(Sigma)) != length(mean) | dim(Sigma)[1] != length(mean)) {

    stop('VCV matrix has incorrect dimensions')
  }
  
  params <- rmvnorm(100, mean = Mean, sigma = Sigma)

  #times <- 0:12/100
  term1 <- a_0^(1-params[,1]/2)
  term2 <- (1-params[,1]/2) * params[,2]*1e-8
  term3 <- (stress*sqrt(pi))^params[,1]
  expon <- 2/(2-params[,1])
  
  crack <- function(time = NULL) {
    
   c.length <- (term1 + term2 * term3*time)^(expon)
    
   return(c.length)
  }
  
  zout <- list()
  zout$term1 <- term1
  zout$term2 <- term2
  zout$term3 <- term3
  zout$expon <- expon
  zout$crack <- crack
  
  return(zout)
}

# a_0 <- 0.025
# t_1 <- 40000 ; t_2 <- 60000
# a_1 <- 0.20  ; a_2 <- 0.40
# 
# a_1^((2-2.05)/2)-a_0^(1-2.05/2)/(t_1*(1-2.05/2)*sqrt(pi)^2.05)
# a_2^((2-2.05)/2)-a_0^(1-2.05/2)/(t_2*(1-2.05/2)*sqrt(pi)^2.05)


a_0 <- 0.9
stress = 1

t_cross <- function(a_0, stress, time) {
  
beta_1 <- rnorm(1,5.17, 0.251)
Term1 <- a_0^(1-beta_1/2)
Term2 <- (1-beta_1/2)
Term3 <- (stress*sqrt(pi))^beta_1 * time
Expon <- 2/(2-beta_1)

  C = (1.6^(1/Expon) - Term1)/(Term2 * Term3)
  
return(C)
}
