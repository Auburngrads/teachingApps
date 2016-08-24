diagram_both <- function() {

    file <- system.file("apps", "diagram_both.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
