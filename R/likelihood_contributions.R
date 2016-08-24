likelihood_contributions <- function() {

    file <- system.file("apps", "likelihood_contributions.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
