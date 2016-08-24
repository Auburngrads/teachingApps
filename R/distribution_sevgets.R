distribution_sevgets <- function() {

    file <- system.file("apps", "distribution_sevgets.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
