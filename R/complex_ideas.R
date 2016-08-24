complex_ideas <- function() {

    file <- system.file("apps", "complex_ideas.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
