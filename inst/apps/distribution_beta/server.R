server = function(input, output, session) {

     add_server('distribution_beta_functions', env = environment())  

output$betafunc <- renderUI({ add_rmd('beta-func.Rmd') })

output$betaprops <- renderUI({ add_rmd('beta-props.Rmd') }) 
}