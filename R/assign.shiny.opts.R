assign.shiny.opts <- 
function(opts, dir, theme = 'flatly', 
         appDir = dir, story = F, css = NULL) {

if(!is.na(more.opts)) { 
aso <- lapply(X = 1:length(more.opts), 
       FUN = function(x) {
             eval(parse(text = paste(collapse = '',
                                     c('shinyOptions(',
                                       names(more.opts[x]),
                                       '=',
                                       more.opts[x],
                                       ')'))))
       })
}

    css <- `if`(is.null(css),
                system.file('css', 'my-shiny.css', package = 'teachingApps'),
                css)

    shinyOptions('theme'   = theme)
    shinyOptions('appDir'  = dir)
    shinyOptions('appName' = basename(dir))
    shinyOptions('story'   = story)
    shinyOptions('css'     = css)

} 