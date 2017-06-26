library(teachingApps)
library('SMRD')

ShockAbsorber.ld <- frame.to.ld(shockabsorber,
                                response.column = 1, 
                                censor.column = 3, 
                                data.title = "Shock Absorber Data (Both Failure Modes)",
                                time.units = "Kilometers")
