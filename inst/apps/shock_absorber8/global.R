par(family = "serif", font = 2)

ShockAbsorber.ld <- frame.to.ld(SMRD::shockabsorber,
                                response.column = 1, 
                                censor.column = 3, 
                                time.units = "Kilometers")