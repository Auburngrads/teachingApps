server = function(input, output, session) {

output$mleback1 <- renderUI({ teachingApps::add_rmd('background1.Rmd') })

output$example1_1 <- renderUI({ teachingApps::add_rmd('example1_1.Rmd') })
  teachingApps::add_server('likelihood_ace', envir = environment())
output$example1_2 <- renderUI({ teachingApps::add_rmd('example1_2.Rmd') })
  teachingApps::add_server('likelihood_ace2', envir = environment())
output$example1_3 <- renderUI({ teachingApps::add_rmd('example1_3.Rmd') })


output$example2_1 <- renderUI({ teachingApps::add_rmd('example2_1.Rmd') })
  teachingApps::add_server('exp_mle', envir = environment())
output$example2_2 <- renderUI({ teachingApps::add_rmd('example2_2.Rmd') })
  teachingApps::add_server('exp_numerical', envir = environment())
output$example2_3 <- renderUI({ teachingApps::add_rmd('example2_3.Rmd') })
  teachingApps::add_server('soln_numerical2', envir = environment())

  
## SERVER FOR SIMULATION
teachingApps:::add_server('likelihood_simulation', envir = environment())


output$details <- renderUI({ teachingApps::add_rmd('details.Rmd') })
}