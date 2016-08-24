shockabsorber_profiles <- function() {

    file <- system.file("apps", "shockabsorber_profiles.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
