superalloy.ld <- frame.to.ld(SMRD::superalloy,
                             response.column = 1, 
                             censor.column = 2,
                             x.columns = c(4,5,6),
                             time.units = "Kilocycles")