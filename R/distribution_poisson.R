distribution_poisson <- function() {

    file <- system.file("apps", "distribution_poisson.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
