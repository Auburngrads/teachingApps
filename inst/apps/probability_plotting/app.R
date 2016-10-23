library(teachingApps)
library('SMRD')

shinyApp(options = list(width = "99%", height = "600px"), 
ui = fluidPage(theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
sidebarLayout(
sidebarPanel(width = 3,
  selectInput("dist1", 
              label = h2("Distribution (Left)"),
              choices = c("Exponential",
                          "Normal",
                          "SEV",
                          "Logistic",
                          "LEV"), 
              selected = "SEV"),
  selectInput("axis1", 
              label = h2("Axis (Left)"),
              choices = c("True Axis",
                          "Transformed Axis"), 
              selected = "True Axis"),
  selectInput("dist2", 
              label = h2("Distribution (Right)"),
              choices = c("Exponential",
                          "Normal",
                          "SEV",
                          "Logistic",
                          "LEV"), 
              selected = "SEV"),
  selectInput("axis2", 
              label = h2("Axis (Right)"),
              choices = c("True Axis",
                          "Transformed Axis"), 
              selected = "Transformed Axis")),

mainPanel(plotOutput("compare", height = "600px"), width = 9)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName))})
  

  
  output$compare <- renderPlot({

CDF<-seq(.01,.99,.03)
par(mfrow = c(1,2),family = "serif",cex = 1.2, mar = c(3.5,4.1,1.5,2.1), las = 1)

switch(input$dist1,"SEV" = { 
WEIB<-(log(log(1/(1-CDF))))
plot(NA,
     xlim = range(1,100),
     ylim = range(WEIB),
     ylab = "",
     xlab = "",
     axes = FALSE)
box(lwd=1.25)
abline(h=WEIB, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression(Phi[SEV](t[p])),line = 2,cex = 1.3)

switch(input$axis1, "True Axis" = {
  
axis(side = 2, labels = NA, at = qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),               
      round(qsev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),
      line=.75)     },
                     "Transformed Axis" = {
axis( side=2, labels = NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),  
      c(".01",".05",".1",".2",".5",".9",".97"),
      line=.75)
})
}, "Normal" = {
LOGN<-(qnorm(CDF))
plot(NA,xlim=range(1,100),ylim=range(LOGN),ylab="",xlab="",axes=FALSE)
abline(h=LOGN, lty=2,col="steelblue")
box(lwd=1.25)
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[NOR](t[p])),line = 2,cex = 1.3)
switch(input$axis1, 
"True Axis"        ={axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qnorm(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },
"Transformed Axis" ={axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Logistic" = {
LLOG<-qlogis(CDF)
plot(NA,xlim=range(1,100),ylim=range(LLOG),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=LLOG, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[logis](t[p])),line = 2,cex = 1.3)
switch(input$axis1, 
"True Axis"        ={axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlogis(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },
"Transformed Axis" ={axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "LEV" = {
LLEV<-qlev(CDF)
plot(NA,xlim=range(1,100),ylim=range(LLEV),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=LLEV, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[LEV](t[p])),line = 2,cex = 1.3)
switch(input$axis1, 
"True Axis"        ={axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)  },
"Transformed Axis" ={axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Exponential" = {
EXP<-qexp(CDF)
plot(NA,xlim=range(1,100),ylim=range(EXP),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=EXP, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( F[EXP](t[p])),line = 2,cex = 1.3)
switch(input$axis1, 
"True Axis"        ={axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qexp(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },
"Transformed Axis" ={axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
})

switch(input$dist2,"SEV" = { 
WEIB<-(log(log(1/(1-CDF))))
plot(NA,xlim=range(1,100),ylim=range(WEIB),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=WEIB, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[SEV](t[p])),line = 2,cex = 1.3)
switch(input$axis2, 
"True Axis"        ={axis( side=2, labels=NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qsev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)  },
"Transformed Axis" ={axis( side=2, labels=NA, at=qsev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qsev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Normal" = {
LOGN<-(qnorm(CDF))
plot(NA,xlim=range(1,100),ylim=range(LOGN),ylab="",xlab="",axes=FALSE)
abline(h=LOGN, lty=2,col="steelblue")
box(lwd=1.25)
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[NOR](t[p])),line = 2,cex = 1.3)
switch(input$axis2, 
"True Axis"        ={axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qnorm(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },
"Transformed Axis" ={axis( side=2, labels=NA, at=qnorm(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qnorm(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Logistic" = {
LLOG<-qlogis(CDF)
plot(NA,xlim=range(1,100),ylim=range(LLOG),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=LLOG, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[logis](t[p])),line = 2,cex = 1.3)
switch(input$axis2, 
"True Axis"        ={axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlogis(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },
"Transformed Axis" ={axis( side=2, labels=NA, at=qlogis(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlogis(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "LEV" = {
LLEV<-qlev(CDF)
plot(NA,xlim=range(1,100),ylim=range(LLEV),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=LLEV, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( Phi[LEV](t[p])),line = 2,cex = 1.3)
switch(input$axis2, 
"True Axis"        ={axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qlev(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)  },
"Transformed Axis" ={axis( side=2, labels=NA, at=qlev(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qlev(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
}, "Exponential" = {
EXP<-qexp(CDF)
plot(NA,xlim=range(1,100),ylim=range(EXP),ylab="",xlab="",axes=FALSE)
box(lwd=1.25)
abline(h=EXP, lty=2,col="steelblue")
axis(side = 1, tck = -.015, labels = NA) ; axis(side = 1, lwd = 0, line = -.6)
mtext(side = 1, expression(t[p]), line = 2.25,cex = 1.3)
mtext(side = 2, expression( F[EXP](t[p])),line = 2,cex = 1.3)
switch(input$axis2, 
"True Axis"        ={axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),               
                    round(qexp(c(.01,.05,.1,.2,.5,.9,.97)),digits = 1),line=.75)     },
"Transformed Axis" ={axis( side=2, labels=NA, at=qexp(c(.01,.02,.05,.1,.2,.5,.9,.97)))
                     mtext(side=2, at=qexp(c(.01,.05,.1,.2,.5,.9,.97)),  
                           c(".01",".05",".1",".2",".5",".9",".97"),line=.75) })
})
par(mfrow = c(1,1))
})
})
