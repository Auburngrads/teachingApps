objs <- function(main.css = getShinyOption("CSS"),
                 user.css = getShinyOption("css"),
                 sign = getShinyOption("appName")) {
  
  return(insertUI('body', 'afterEnd',
         ui = list(tags$head(includeCSS(main.css)),
                   tags$head(includeCSS(user.css)),
                   tags$footer(HTML(teachingApps::signature(sign))))))
}