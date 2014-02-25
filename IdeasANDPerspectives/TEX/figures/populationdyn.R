library(animation)
library(igraph)

npoints<-5000;
nspecies<-5;

colors<-runif(npoints,1,nspecies);

y<-runif(npoints,0,1)
x<-runif(npoints,0,1)

png("./metacommunity.png",width=800,height=800);
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)
	box();
dev.off();



png("./multitrophicmetacommunity.png",width=800,height=800);
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)
	
	percent<-0.2;
	ymin<-0
	ymax<-0.1
	while(ymax <= 1){
		xmin<-0
		xmax<-0.1
		while(xmax <= 1){
			yrange<-which((y>ymin) & (y<ymax))
			xrange<-which((x>xmin) & (x<xmax))
			xyrange<-intersect(xrange,yrange)
			subsample<-sample(xyrange,percent*length(xyrange))
			lines(x[subsample],y[subsample])
	
			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
	box();
dev.off();
