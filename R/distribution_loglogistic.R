distribution_loglogistic <- function() {

    file <- system.file("apps", "distribution_loglogistic.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
