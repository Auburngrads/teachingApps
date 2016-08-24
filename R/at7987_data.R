at7987_data <- function() {

    file <- system.file("apps", "at7987_data.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
