distribution_norgets <- function() {

    file <- system.file("apps", "distribution_norgets.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
