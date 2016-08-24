distribution_binomial <- function() {

    file <- system.file("apps", "distribution_binomial.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
