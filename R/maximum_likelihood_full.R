maximum_likelihood_full <- function() {

    file <- system.file("apps", "maximum_likelihood_full.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
