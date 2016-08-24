zelen_cap <- function() {

    file <- system.file("apps", "zelen_cap.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
