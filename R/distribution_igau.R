distribution_igau <- function() {

    file <- system.file("apps", "distribution_igau.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
