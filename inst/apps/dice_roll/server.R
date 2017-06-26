server = function(input, output, session) {

  
dice   <- reactive({ as.numeric(input$no.dice) })
sides  <- reactive({ as.numeric(input$no.sides) })
fun    <- reactive({ switch(input$rv.func, 'Sum of Rolls' = 'sum',
                                'Product of Rolls' = 'prod',
                                'Difference of Rolls' = 'diff')})
events <- reactive({ unique(combn(rep(1:sides(),dice()),dice(), simplify = FALSE))})
omega  <- reactive({ as.numeric(attr(table(unlist(lapply(events(), FUN = fun()))),'dimnames')[[1]])})
counts <- reactive({ table(unlist(lapply(events(), FUN = fun()))) })
data   <- reactive({ rep(omega(),counts()) })
  
output$results <- DT::renderDataTable({ 

if(dice()==1 & as.character(fun())=='diff') { 
  
  stop('\nHow do you expect to find the difference with only one number?\n')
  
} else {
  
outcomes <- list()

for (i in 1:length(omega())) {
    
outcomes[[i]] <-lapply(events()[which(unlist(lapply(events(), fun()))==omega()[i])], 
                       FUN = function(x)  noquote(paste(c(x), collapse = ',')))
}

Outcomes <-matrix(sort(noquote(unlist(outcomes))), byrow = FALSE, 
                  nrow = length(unlist(outcomes))/sides())

  
  DT::datatable(Outcomes,options = list(pageLength = sides())) 
}
}) 
  
output$diceresults <- renderPlot({

if(dice()==1 & as.character(fun())=='diff') { 
  
  stop('\nHow do you expect to find the difference with only one number?\n')
  
} else {
  
par(mar = c(5,4.5,0,1), font = 2, cex = 1.1)

hist(data(), 
     breaks = (min(omega())-0.5):(max(omega())+0.5), 
     xlim = extendrange(omega()), main = '', las = 1, 
     col = rainbow(length(omega())), 
     xlab = parse(text = toupper(paste(c('sample~space %->%',fun(),'~of~',dice(),'~dice~rolls~(', sides(),'-sided~die)'), collapse = ''))),
     xaxt = 'n')

axis(side = 1, labels = omega(), at = omega())

if (sides() <= 8 & as.character(fun())%in%c('sum','diff')) {

for (i in 1:length(omega())) {
  
  text(x = rep( omega()[i],counts()[i]), 
       y = 0.5:counts()[ i], 
       lapply(events()[which(unlist(lapply(events(), fun()))==omega()[i])], 
              FUN = function(x) noquote(paste(c(x), collapse = ','))), 
       cex = sqrt(6/sides()))
}}}
})
      
output$diceprobs <- renderPlot({

if(dice()==1 & as.character(fun())=='diff') { 
  
  stop('\nHow do you expect to find the difference with only one number?\n')
  
} else {

  par(mar = c(5,4.5,0,1), font = 2, cex = 1.1)
    
hist(data(), 
     breaks = (min(omega())-0.5):(max(omega())+0.5), 
     xlim = extendrange(omega()), main = '', las = 1, 
     col = rainbow(length(omega())), 
     xlab = parse(text = toupper(paste(c('sample~space%->%', fun(),'~of~',dice(),'~dice~rolls~(', sides(),'-sided~die)'), collapse = ''))),
     xaxt = 'n', 
     prob = TRUE, 
     ylim = extendrange(c(0,max(counts())/sum(counts()))*1.1))

axis(side = 1, labels = omega(), at = omega())

if (!((dice()>= 3 | sides() > 8) & as.character(fun())=='prod')) {

for (i in 1:length(omega())) {
  
  text(x = omega()[i], 
       y = (counts()[i]/sum(counts())), 
       round(counts()[i]/sum(counts()), digits = 3), 
       cex = (10/sides())-(2/sides()), srt = 90, adj = -0.1,
       col = rainbow(length(omega()))[i], font = 2)
}}}
})
}