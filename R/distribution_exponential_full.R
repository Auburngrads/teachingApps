distribution_exponential_full <- function() {

    file <- system.file("apps", "distribution_exponential_full.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
