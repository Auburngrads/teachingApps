expand.vec <-
function (a, nplan) 
{
    if (length(a) == 1) {
        a <- rep(a, length = nplan)
    }
    if (length(a) != nplan) 
        stop(paste(deparse(substitute(a)), "has length", length(a), 
            "for", nplan, "plans"))
    return(a)
}
