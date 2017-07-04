server = function(input, output, session) {

output$mleback1 <- renderUI({ teachingApps::add_rmd('background1.Rmd') })

output$example1_1 <- renderUI({ teachingApps::add_rmd('example1_1.Rmd') })
  teachingApps::add_server('maximum_likelihood_1obs', envir = environment())
output$example1_2 <- renderUI({ teachingApps::add_rmd('example1_2.Rmd') })
  teachingApps::add_server('maximum_likelihood_2obs', envir = environment())
output$example1_3 <- renderUI({ teachingApps::add_rmd('example1_3.Rmd') })


output$example2_1 <- renderUI({ teachingApps::add_rmd('example2_1.Rmd') })
  teachingApps::add_server('maximum_likelihood_graphical_exp', envir = environment())
output$example2_2 <- renderUI({ teachingApps::add_rmd('example2_2.Rmd') })
  teachingApps::add_server('maximum_likelihood_numerical_exp', envir = environment())
output$example2_3 <- renderUI({ teachingApps::add_rmd('example2_3.Rmd') })
  teachingApps::add_server('maximum_likelihood_numerical_other', envir = environment())

  
## SERVER FOR SIMULATION
teachingApps::add_server('maximum_likelihood_simulation', envir = environment())


output$details <- renderUI({ teachingApps::add_rmd('details.Rmd') })
}