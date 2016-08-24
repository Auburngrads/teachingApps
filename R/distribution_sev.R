distribution_sev <- function() {

    file <- system.file("apps", "distribution_sev.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
