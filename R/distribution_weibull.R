distribution_weibull <- function() {

    file <- system.file("apps", "distribution_weibull.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
