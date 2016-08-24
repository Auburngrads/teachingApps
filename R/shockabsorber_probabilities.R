shockabsorber_probabilities <- function() {

    file <- system.file("apps", "shockabsorber_probabilities.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
