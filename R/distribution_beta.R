distribution_beta <- function() {

    file <- system.file("apps", "distribution_beta.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
