server = function(input, output, session) {

output$ci_intro <- renderUI({ add_rmd('intro.Rmd') })
  
## SERVER FOR SIMULATION
     add_server('confidence_intervals_simulation', env = environment())

}