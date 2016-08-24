distribution_bisa <- function() {

    file <- system.file("apps", "distribution_bisa.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
