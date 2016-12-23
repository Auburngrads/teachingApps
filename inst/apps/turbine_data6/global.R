par(family = "serif",font = 2)
Turbine.ld <- frame.to.ld(SMRD::turbine,
                          response.column = 1,
                          censor.column = 2,
                          case.weight.column=3,
                          time.units = "Hundred Hours")