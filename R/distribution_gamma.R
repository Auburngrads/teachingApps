distribution_gamma <- function() {

    file <- system.file("apps", "distribution_gamma.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
