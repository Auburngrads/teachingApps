confidence_intervals <- function() {

    file <- system.file("apps", "confidence_intervals.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
