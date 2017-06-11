par(family = "serif", font = 2)

library(teachingApps)
library(SMRD)

ShockAbsorber.ld <- 
  frame.to.ld(shockabsorber,
              response.column = 1, 
              censor.column = 3, 
              time.units = "Kilometers")