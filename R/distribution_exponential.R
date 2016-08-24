distribution_exponential <- function() {

    file <- system.file("apps", "distribution_exponential.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
