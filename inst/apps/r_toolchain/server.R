server = function(input, output, session) {

output$rwindows  <- renderUI({ teachingApps::add_rmd('rwin.Rmd' ) })
output$rmac      <- renderUI({ teachingApps::add_rmd('rmac.Rmd' ) }) 
output$rlinux    <- renderUI({ teachingApps::add_rmd('rlin.Rmd' ) })

output$rswindows <- renderUI({ teachingApps::add_rmd('rswin.Rmd') })
output$rsmac     <- renderUI({ teachingApps::add_rmd('rsmac.Rmd') }) 
output$rslinux   <- renderUI({ teachingApps::add_rmd('rslin.Rmd') })

output$rtwindows <- renderUI({ teachingApps::add_rmd('rtwin.Rmd') })
output$rtmac     <- renderUI({ teachingApps::add_rmd('rtmac.Rmd') }) 
output$rtlinux   <- renderUI({ teachingApps::add_rmd('rtlin.Rmd') })

output$rlwindows <- renderUI({ teachingApps::add_rmd('rlwin.Rmd') })
output$rlmac     <- renderUI({ teachingApps::add_rmd('rlmac.Rmd') }) 
output$rllinux   <- renderUI({ teachingApps::add_rmd('rllin.Rmd') })

output$rgwindows <- renderUI({ teachingApps::add_rmd('rgwin.Rmd') })
output$rgmac     <- renderUI({ teachingApps::add_rmd('rgmac.Rmd') }) 
output$rglinux   <- renderUI({ teachingApps::add_rmd('rglin.Rmd') })

}