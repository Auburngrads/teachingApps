server = function(input, output, session) {

output$rwindows  <- renderUI({ teachingApps::nestRmd('rwin.Rmd' ) })
output$rmac      <- renderUI({ teachingApps::nestRmd('rmac.Rmd' ) }) 
output$rlinux    <- renderUI({ teachingApps::nestRmd('rlin.Rmd' ) })

output$rswindows <- renderUI({ teachingApps::nestRmd('rswin.Rmd') })
output$rsmac     <- renderUI({ teachingApps::nestRmd('rsmac.Rmd') }) 
output$rslinux   <- renderUI({ teachingApps::nestRmd('rslin.Rmd') })

output$rtwindows <- renderUI({ teachingApps::nestRmd('rtwin.Rmd') })
output$rtmac     <- renderUI({ teachingApps::nestRmd('rtmac.Rmd') }) 
output$rtlinux   <- renderUI({ teachingApps::nestRmd('rtlin.Rmd') })

output$rlwindows <- renderUI({ teachingApps::nestRmd('rlwin.Rmd') })
output$rlmac     <- renderUI({ teachingApps::nestRmd('rlmac.Rmd') }) 
output$rllinux   <- renderUI({ teachingApps::nestRmd('rllin.Rmd') })

output$rgwindows <- renderUI({ teachingApps::nestRmd('rgwin.Rmd') })
output$rgmac     <- renderUI({ teachingApps::nestRmd('rgmac.Rmd') }) 
output$rglinux   <- renderUI({ teachingApps::nestRmd('rglin.Rmd') })

}