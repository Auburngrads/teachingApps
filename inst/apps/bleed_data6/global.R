library(teachingApps)
library('SMRD')


Bleed.ld <- frame.to.ld(SMRD::bleed,
                        response.column = 1, 
                        censor.column = 2, 
                        case.weight.column = 3,
                        x.columns = c(4),
                        time.units = "Hours")

Bleed.Dbase.ld <-     ld.split(Bleed.ld, stress.var.list = "D")
Bleed.Otherbase.ld <- ld.split(Bleed.ld, stress.var.list = "Other")
