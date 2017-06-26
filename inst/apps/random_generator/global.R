library(teachingApps)
needs::needs(DT)

set.seed(NULL) ; set1 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(NULL) ; set2 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(42)   ; set3 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
set.seed(42)   ; set4 <- sort(round(rlnorm(8, 0.75, 1.5), digits = 4))
