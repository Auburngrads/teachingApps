distribution_goma <- function() {

    file <- system.file("apps", "distribution_goma.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
