source("./populationdyn.R")
ymin<-0
ymax<-0.1
xmin<-0
xmax<-0.1
which((y>ymin) & (y<ymax))
yrange<-which((y>ymin) & (y<ymax))
xrange<-which((x>ymin) & (x<ymax))
xrange
yrange
intersect(xrange,yrange)
xyrange<-intersect(xrange,yrange)
plot(x,y,col=colors)
line(xyrange)
lines(xyrange)
lines(x[xyrange],y[xyrange])
savehistory("./log.R")
?sample
xyrange
length(xyrange)
sample(xyrange,prob=0.2)
sample(xyrange,prob=rep(0.2,45))
?sample
savehistory("./log.R")
?rep
??probability
??sample
sample(xyrange)
sample(xyrange,n=0.2*length(xyrange))
0.2*length(xyrange)
sample(xyrange,0.2*length(xyrange))
subsample<-sample(xyrange,0.2*length(xyrange))
savehistory("./log.R")
