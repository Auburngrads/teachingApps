server = function(input, output, session) {

output$betaover <- renderUI({ add_rmd('overview.Rmd') })

     add_server('distribution_beta_functions', env = environment())  

output$betafunc <- renderUI({ add_rmd('beta-func.Rmd') })

output$betaprops <- renderUI({ add_rmd('beta-props.Rmd') }) 
}