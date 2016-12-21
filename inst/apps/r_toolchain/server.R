server = function(input, output, session) {

output$rwindows  <- renderUI({ teachingApps::insertRmd('rwin.Rmd' ) })
output$rmac      <- renderUI({ teachingApps::insertRmd('rmac.Rmd' ) }) 
output$rlinux    <- renderUI({ teachingApps::insertRmd('rlin.Rmd' ) })

output$rswindows <- renderUI({ teachingApps::insertRmd('rswin.Rmd') })
output$rsmac     <- renderUI({ teachingApps::insertRmd('rsmac.Rmd') }) 
output$rslinux   <- renderUI({ teachingApps::insertRmd('rslin.Rmd') })

output$rtwindows <- renderUI({ teachingApps::insertRmd('rtwin.Rmd') })
output$rtmac     <- renderUI({ teachingApps::insertRmd('rtmac.Rmd') }) 
output$rtlinux   <- renderUI({ teachingApps::insertRmd('rtlin.Rmd') })

output$rlwindows <- renderUI({ teachingApps::insertRmd('rlwin.Rmd') })
output$rlmac     <- renderUI({ teachingApps::insertRmd('rlmac.Rmd') }) 
output$rllinux   <- renderUI({ teachingApps::insertRmd('rllin.Rmd') })

output$rgwindows <- renderUI({ teachingApps::insertRmd('rgwin.Rmd') })
output$rgmac     <- renderUI({ teachingApps::insertRmd('rgmac.Rmd') }) 
output$rglinux   <- renderUI({ teachingApps::insertRmd('rglin.Rmd') })

}