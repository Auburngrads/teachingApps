distribution_logistic <- function() {

    file <- system.file("apps", "distribution_logistic.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
