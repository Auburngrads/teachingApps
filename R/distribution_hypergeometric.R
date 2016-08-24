distribution_hypergeometric <- function() {

    file <- system.file("apps", "distribution_hypergeometric.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
