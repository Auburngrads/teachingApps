shockabsorber_quantiles <- function() {

    file <- system.file("apps", "shockabsorber_quantiles.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
