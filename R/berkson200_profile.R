berkson200_profile <- function() {

    file <- system.file("apps", "berkson200_profile.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
