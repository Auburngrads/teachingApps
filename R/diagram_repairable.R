diagram_repairable <- function() {

    file <- system.file("apps", "diagram_repairable.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
