simultaneous_skills <- function() {

    file <- system.file("apps", "simultaneous_skills.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
