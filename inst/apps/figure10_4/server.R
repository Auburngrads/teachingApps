server = function(input, output, session) {
  
  output$simulate <- renderPlot({

para<-matrix(NA,nrow=input$sim,ncol=2)
param<-matrix(NA,nrow=input$sim,ncol=2)

par(family="serif")

y<-matrix(NA,nrow=input$sim,ncol=2)

switch(input$dis, "Weibull" = {

plot(NA,
     xlim=range(10,10000),
     ylim=range(log(log(1/(1-c(.01,.02,.05,.1,.2,.5,.9,.98))))),
     xlab="",
     ylab="",
     axes=FALSE,
     log="x")

obs.w<-replicate(input$sim,rweibull(input$n,shape=1/1.244,scale=exp(8.774)))

for(i in 1:input$sim){

w.ll<-function(x) {  b<-x[1]; t<-x[2]
  
  n<-length(obs.w[,i])
  LL<-c(rep(NA,1))
  LL<-n*log(b)-n*b*log(t)+(b-1)*sum(log(obs.w[,i]))-sum((obs.w[,i]/t)^b)
  
  return(-LL)   }

para[i,1:2]<-nlminb(c(1.15,2500),objective=w.ll)$par

y[i,1:2]<-log(log(1/(1-pweibull(c(10,10000),shape=para[i,1],scale=para[i,2]))))

lines(rep(c(10,10000)),y[i,],col = "red", lwd = 2)

}

box(lwd=1.25)
abline(h=log(log(1/.9)),v=1000, lty=2,col="steelblue")
axis(side = 1, 
     tck = -.015, 
     labels = NA) 
axis(side = 1, 
     lwd = 0, 
     cex.axis = 1.5)
axis(side = 2, 
     labels = NA,
     at=log(log(1/(1-c(.01,.02,.05,.1,.2,.5,.9,.98)))))
mtext(side = 1, 
      expression(t[p]), 
      line = 2.5,
      cex = 1.5)
mtext(side = 2,
      expression( Phi[SEV](t[p])),
      line = 2,
      cex = 1.5)
mtext(side = 2,
      at=log(log(1/(1-c(.01,.05,.1,.2,.5,.9,.98)))),c(".01",".05",".1",".2",".5",".9",".98"),
      line=.75, 
      cex=1.5,
      adj=1,
      las = 1)

}, "Lognormal" = {
  
plot(NA,
     xlim = range(10,10000),
     ylim = range(qnorm(c(.01,.02,.05,.1,.2,.5,.9,.98))),
     xlab = "",
     ylab = "",
     axes = FALSE,
     log = "x")
  
obs.l<-replicate(input$sim,rlnorm(input$n,meanlog=8.658,sdlog=2.079))

for(i in 1:input$sim){

param[i,1]<-sum(log(obs.l[,i]))/length(obs.l[,i])
param[i,2]<-sum((log(obs.l[,i])-param[i,1])^2)/length(obs.l[,i])


y[i,1:2]<-qnorm(plnorm(c(10,10000),meanlog=param[i,1],sdlog=param[i,2]))

lines(rep(c(10,10000)),y[i,], lwd = 2)

}

box(lwd=1.25)
abline(h = qnorm(.1),v = 1000, lty = 2,col = "steelblue")
axis(side = 1, 
     tck = -.015, 
     labels = NA)
axis(side = 1,
     lwd = 0,
     cex.axis = 1.5)
axis(side = 2, 
     labels = NA,
     at = qnorm(c(.01,.02,.05,.1,.2,.5,.9,.98)))
mtext(side = 1, 
      expression(t[p]),
      line = 2.5,
      cex = 1.5)
mtext(side = 2,
      expression( Phi[NOR](t[p])),
      line = 2,
      cex = 1.5)
mtext(side = 2,
      at = qnorm(c(.01,.05,.1,.2,.5,.9,.98)),c(".01",".05",".1",".2",".5",".9",".98"),
      line = .75, 
      cex = 1.5,
      adj = 1,
      las = 1)
  
})
})
}