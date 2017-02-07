assign.shiny.opts <- 
function(opts, dir, theme = 'flatly', 
         story = F, css = NULL) {

if(!is.na(opts)) { 
aso <- lapply(X = 1:length(opts), 
       FUN = function(x) {
             eval(parse(text = paste(collapse = '',
                                     c('shiny::shinyOptions(',
                                       names(opts[x]),
                                       '=',
                                       opts[x],
                                       ')'))))
       })
}

    css <- `if`(is.null(css),
                system.file('resources','css','teachingApps.css', package = 'teachingApps'),
                css)
    
    sign <- `if`(story,
                 NULL,
                 HTML(teachingApps::signature(basename(dir))))

    shiny::shinyOptions('theme'   = theme)
    shiny::shinyOptions('appDir'  = dir)
    shiny::shinyOptions('appName' = basename(dir))
    shiny::shinyOptions('story'   = story)
    shiny::shinyOptions('css'     = css)
    shiny::shinyOptions('sign'    = sign)
    
    if(!story)
       options('markdown.HTML.stylesheet' = shiny::getShinyOption("css"))


} 