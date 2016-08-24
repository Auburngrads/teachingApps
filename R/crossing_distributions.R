crossing_distributions <- function() {

    file <- system.file("apps", "crossing_distributions.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
