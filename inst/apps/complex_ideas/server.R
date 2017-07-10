server = function(input, output, session) {

     add_server('confidence_intervals', 
                env = environment())
     add_server('central_limit',        
                env = environment())
     add_server('probability_plotting', 
                env = environment())
     add_server('distribution_weibull_functions', 
                env = environment())
     add_server('maximum_likelihood_simulation',   
                env = environment())
     add_server('dice_roll',
                env = environment())

}