server = function(input, output, session) {

output$mleback1 <- renderUI({ teachingApps::insertRmd('background1.Rmd') })

output$example1_1 <- renderUI({ teachingApps::insertRmd('example1_1.Rmd') })
  teachingApps::insertServer('likelihood_ace', envir = environment())
output$example1_2 <- renderUI({ teachingApps::insertRmd('example1_2.Rmd') })
  teachingApps::insertServer('likelihood_ace2', envir = environment())
output$example1_3 <- renderUI({ teachingApps::insertRmd('example1_3.Rmd') })


output$example2_1 <- renderUI({ teachingApps::insertRmd('example2_1.Rmd') })
  teachingApps::insertServer('exp_mle', envir = environment())
output$example2_2 <- renderUI({ teachingApps::insertRmd('example2_2.Rmd') })
  teachingApps::insertServer('exp_numerical', envir = environment())
output$example2_3 <- renderUI({ teachingApps::insertRmd('example2_3.Rmd') })
  teachingApps::insertServer('soln_numerical2', envir = environment())

  
## SERVER FOR SIMULATION
teachingApps:::insertServer('maximum_likelihood', envir = environment())


output$details <- renderUI({ teachingApps::insertRmd('details.Rmd') })
}