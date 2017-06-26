library(teachingApps)
library('SMRD')

HeatExchanger.ld <- frame.to.ld(SMRD::heatexchanger,
                                response.column = c(1,2),
                                censor.column = 3,
                                case.weight.column=4,
                                data.title = "Heat Exchanger Crack Data",
                                time.units = "Years")
