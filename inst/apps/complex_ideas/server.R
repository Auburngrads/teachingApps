server = function(input, output, session) {

teachingApps::nestServer('confidence_intervals', envir = environment())
teachingApps::nestServer('central_limit',        envir = environment())
teachingApps::nestServer('probability_plotting', envir = environment())
teachingApps::nestServer('distribution_weibull', envir = environment())
teachingApps::nestServer('maximum_likelihood',   envir = environment())
teachingApps::nestServer('dice_roll',            envir = environment())

}