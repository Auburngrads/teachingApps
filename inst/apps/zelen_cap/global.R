library(teachingApps)
library('SMRD')
needs::needs(DT)

ZelenCap.ld <- frame.to.ld(zelencap, 
                           response.column = 1, 
                           censor.column = 2, 
                           case.weight.column = 3,
                           x.columns = c(4, 5),
                           time.units = "Hours", 
                           xlabel = c(expression(C^o), expression("Volts")))
