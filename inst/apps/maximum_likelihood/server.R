server = function(input, output, session) {

output$mleback1 <- renderUI({ add_rmd('background1.Rmd') })

output$example1_1 <- renderUI({ add_rmd('example1_1.Rmd') })
       add_server('maximum_likelihood_1obs', env = environment())
output$example1_2 <- renderUI({ add_rmd('example1_2.Rmd') })
       add_server('maximum_likelihood_2obs', env = environment())
output$example1_3 <- renderUI({ add_rmd('example1_3.Rmd') })


output$example2_1 <- renderUI({ add_rmd('example2_1.Rmd') })
       add_server('maximum_likelihood_graphical_exp', env = environment())
output$example2_2 <- renderUI({ add_rmd('example2_2.Rmd') })
       add_server('maximum_likelihood_numerical_exp', env = environment())
output$example2_3 <- renderUI({ add_rmd('example2_3.Rmd') })
       add_server('maximum_likelihood_numerical_other', env = environment())

  
## SERVER FOR SIMULATION
     add_server('maximum_likelihood_simulation', env = environment())


output$details <- renderUI({ add_rmd('details.Rmd') })
}