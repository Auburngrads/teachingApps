server = function(input, output, session) {

output$mleback1 <- renderUI({ teachingApps::nestRmd('background1.Rmd') })

output$example1_1 <- renderUI({ teachingApps::nestRmd('example1_1.Rmd') })
  teachingApps::nestServer('likelihood_ace', envir = environment())
output$example1_2 <- renderUI({ teachingApps::nestRmd('example1_2.Rmd') })
  teachingApps::nestServer('likelihood_ace2', envir = environment())
output$example1_3 <- renderUI({ teachingApps::nestRmd('example1_3.Rmd') })


output$example2_1 <- renderUI({ teachingApps::nestRmd('example2_1.Rmd') })
  teachingApps::nestServer('exp_mle', envir = environment())
output$example2_2 <- renderUI({ teachingApps::nestRmd('example2_2.Rmd') })
  teachingApps::nestServer('exp_numerical', envir = environment())
output$example2_3 <- renderUI({ teachingApps::nestRmd('example2_3.Rmd') })
  teachingApps::nestServer('soln_numerical2', envir = environment())

  
## SERVER FOR SIMULATION
teachingApps:::nestServer('likelihood_simulation', envir = environment())


output$details <- renderUI({ teachingApps::nestRmd('details.Rmd') })
}