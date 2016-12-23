server = function(input, output, session) {

teachingApps::insertServer('confidence_intervals', envir = environment())
teachingApps::insertServer('central_limit',        envir = environment())
teachingApps::insertServer('probability_plotting', envir = environment())
teachingApps::insertServer('distribution_weibull', envir = environment())
teachingApps::insertServer('maximum_likelihood',   envir = environment())
teachingApps::insertServer('dice_roll',            envir = environment())

}