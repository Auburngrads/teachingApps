diagram_nonrepairable <- function() {

    file <- system.file("apps", "diagram_nonrepairable.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
