server = function(input, output, session) {
  
     add_server('distribution_normal_functions', env = environment()) 
  
output$norfunc  <- renderUI({ add_rmd('nor-func.Rmd') })

output$norprops <- renderUI({ add_rmd('nor-props.Rmd') }) 
}