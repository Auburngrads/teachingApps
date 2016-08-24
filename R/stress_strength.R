stress_strength <- function() {

    file <- system.file("apps", "stress_strength.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
