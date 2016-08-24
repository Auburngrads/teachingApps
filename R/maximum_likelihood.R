maximum_likelihood <- function() {

    file <- system.file("apps", "maximum_likelihood.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
