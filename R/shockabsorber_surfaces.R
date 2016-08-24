shockabsorber_surfaces <- function() {

    file <- system.file("apps", "shockabsorber_surfaces.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
