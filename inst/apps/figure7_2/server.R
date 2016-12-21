server = function(input, output, session) {
  
  output$berksonrel <- renderPlot({
  
    Like<-function(theta,d) {

F<-log(exp(   -0/theta)-exp( -100/theta))*d[1]+
   log(exp( -100/theta)-exp( -300/theta))*d[2]+
   log(exp( -300/theta)-exp( -500/theta))*d[3]+
   log(exp( -500/theta)-exp( -700/theta))*d[4]+
   log(exp( -700/theta)-exp(-1000/theta))*d[5]+
   log(exp(-1000/theta)-exp(-2000/theta))*d[6]+
   log(exp(-2000/theta)-exp(-4000/theta))*d[7]+
   log(exp(-4000/theta)-exp( -Inf/theta))*d[8] 

return(-F)      }

data<-matrix(c(3,7,4,1,3,2,0,0,
               41,44,24,32,29,21,9,0,
               292,494,332,236,261,308,73,4,
               1609,2424,1770,1306,1213,1528,354,16),
             nrow=4, byrow=TRUE)

P.1<-(nlminb(start=400,Like,d=data[1,],lower=100,upper=800,control=list(trace=FALSE))$par) 
P.2<-(nlminb(start=400,Like,d=data[2,],lower=100,upper=800,control=list(trace=FALSE))$par)
P.3<-(nlminb(start=400,Like,d=data[3,],lower=100,upper=800,control=list(trace=FALSE))$par)
P.4<-(nlminb(start=400,Like,d=data[4,],lower=100,upper=800,control=list(trace=FALSE))$par)

x<-seq(200,800,.1)

RL.1<-exp(-Like(x,data[1,])+Like(P.1,data[1,]))
RL.2<-exp(-Like(x,data[2,])+Like(P.2,data[2,]))
RL.3<-exp(-Like(x,data[3,])+Like(P.3,data[3,]))
RL.4<-exp(-Like(x,data[4,])+Like(P.4,data[4,]))

par(family="serif",font=2)

if(input$n7.2==20) {  
plot (x,RL.1,type="l",col=rgb(1,0,0,  1),xlim=range(x),lwd=2,xlab="",ylab="",axes=F)
lines(x,RL.2,type="l",col=rgb(0,1,0,.05),xlim=range(x),lwd=2)
lines(x,RL.3,type="l",col=rgb(0,0,1,.05),xlim=range(x),lwd=2)
lines(x,RL.4,type="l",col=rgb(0,0,0,.05),xlim=range(x),lwd=2)
abline(h= exp(-qchisq(as.numeric(input$ci7.2)/100,1)/2),lwd = 1.5)

box(lwd=1.25)

axis(side = 2, lwd = 0, line = -.6, las = 1) ; axis(side = 1, tck = -.015, labels=NA)
axis(side = 1, lwd = 0, line = -.6         ) ; axis(side = 2, tck = -.015, labels=NA)

mtext(side = 1, expression(theta), line = 2.25,cex = 2)
mtext(side = 2, 
      expression("R("*theta*") = L("*theta*")/L("*hat(theta)[scriptscriptstyle(MLE)]*")"), 
      line = 2,cex = 1.5) } 

else
  
if(input$n7.2==200) {  
plot (x,RL.2,type="l",col=rgb(0,1,0,  1),xlim=range(x),lwd=2,xlab="",ylab="",axes=F)
lines(x,RL.1,type="l",col=rgb(1,0,0,.05),xlim=range(x),lwd=2)
lines(x,RL.3,type="l",col=rgb(0,0,1,.05),xlim=range(x),lwd=2)
lines(x,RL.4,type="l",col=rgb(0,0,0,.05),xlim=range(x),lwd=2)  
abline(h= exp(-qchisq(as.numeric(input$ci7.2)/100,1)/2),lwd = 1.5)

box(lwd=1.25)

axis(side = 2, lwd = 0, line = -.6, las = 1) ; axis(side = 1, tck = -.015, labels=NA)
axis(side = 1, lwd = 0, line = -.6         ) ; axis(side = 2, tck = -.015, labels=NA)

mtext(side = 1, expression(theta), line = 2.25,cex = 2)
mtext(side = 2, expression("R("*theta*") = L("*theta*")/L("*hat(theta)[scriptscriptstyle(MLE)]*")"),line = 2,cex = 1.5) } 

else

if(input$n7.2==2000) {  
plot (x,RL.3,type="l",col=rgb(0,0,1,  1),xlim=range(x),lwd=2,xlab="",ylab="",axes=F)
lines(x,RL.2,type="l",col=rgb(0,1,0,.05),xlim=range(x),lwd=2)
lines(x,RL.1,type="l",col=rgb(1,0,0,.05),xlim=range(x),lwd=2)
lines(x,RL.4,type="l",col=rgb(0,0,0,.05),xlim=range(x),lwd=2)
abline(h= exp(-qchisq(as.numeric(input$ci7.2)/100,1)/2),lwd = 1.5)

box(lwd=1.25)

axis(side = 2, lwd = 0, line = -.6, las = 1) ; axis(side = 1, tck = -.015, labels=NA)
axis(side = 1, lwd = 0, line = -.6         ) ; axis(side = 2, tck = -.015, labels=NA)

mtext(side = 1, expression(theta), line = 2.25,cex = 2)
mtext(side = 2, expression("R("*theta*") = L("*theta*")/L("*hat(theta)[scriptscriptstyle(MLE)]*")"),line = 2,cex = 1.5) } 

else

if(input$n7.2==10220) {  
plot (x,RL.4,type="l",col=rgb(0,0,0,  1),xlim=range(x),lwd=2,xlab="",ylab="",axes=F)
lines(x,RL.3,type="l",col=rgb(0,0,1,.05),xlim=range(x),lwd=2)
lines(x,RL.2,type="l",col=rgb(0,1,0,.05),xlim=range(x),lwd=2)
lines(x,RL.1,type="l",col=rgb(1,0,0,.05),xlim=range(x),lwd=2)
abline(h= exp(-qchisq(as.numeric(input$ci7.2)/100,1)/2),lwd = 1.5)

box(lwd=1.25)

axis(side = 2, lwd = 0, line = -.6, las = 1) ; axis(side = 1, tck = -.015, labels=NA)
axis(side = 1, lwd = 0, line = -.6         ) ; axis(side = 2, tck = -.015, labels=NA)

mtext(side = 1, expression(theta), line = 2.25,cex = 2)
mtext(side = 2, expression("R("*theta*") = L("*theta*")/L("*hat(theta)[scriptscriptstyle(MLE)]*")"),line = 2,cex = 1.5) }
})
}