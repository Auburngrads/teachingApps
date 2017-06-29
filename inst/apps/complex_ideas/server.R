server = function(input, output, session) {

teachingApps::add_server('confidence_intervals', envir = environment())
teachingApps::add_server('central_limit',        envir = environment())
teachingApps::add_server('probability_plotting', envir = environment())
teachingApps::add_server('distribution_weibull', envir = environment())
teachingApps::add_server('maximum_likelihood',   envir = environment())
teachingApps::add_server('dice_roll',            envir = environment())

}