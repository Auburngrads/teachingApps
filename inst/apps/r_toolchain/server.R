server = function(input, output, session) {

output$rwindows  <- renderUI({ add_rmd('rwin.Rmd' ) })
output$rmac      <- renderUI({ add_rmd('rmac.Rmd' ) }) 
output$rlinux    <- renderUI({ add_rmd('rlin.Rmd' ) })

output$rswindows <- renderUI({ add_rmd('rswin.Rmd') })
output$rsmac     <- renderUI({ add_rmd('rsmac.Rmd') }) 
output$rslinux   <- renderUI({ add_rmd('rslin.Rmd') })

output$rtwindows <- renderUI({ add_rmd('rtwin.Rmd') })
output$rtmac     <- renderUI({ add_rmd('rtmac.Rmd') }) 
output$rtlinux   <- renderUI({ add_rmd('rtlin.Rmd') })

output$rlwindows <- renderUI({ add_rmd('rlwin.Rmd') })
output$rlmac     <- renderUI({ add_rmd('rlmac.Rmd') }) 
output$rllinux   <- renderUI({ add_rmd('rllin.Rmd') })

output$rgwindows <- renderUI({ add_rmd('rgwin.Rmd') })
output$rgmac     <- renderUI({ add_rmd('rgmac.Rmd') }) 
output$rglinux   <- renderUI({ add_rmd('rglin.Rmd') })

}