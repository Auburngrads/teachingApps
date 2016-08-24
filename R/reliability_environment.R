reliability_environment <- function() {

    file <- system.file("apps", "reliability_environment.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
