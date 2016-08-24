censored_eventplots <- function() {

    file <- system.file("apps", "censored_eventplots.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
