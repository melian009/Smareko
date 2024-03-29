library(animation)
library(igraph)

npoints<-5000;
nspecies<-5;

colors<-runif(npoints,1,nspecies);

y<-runif(npoints,0,1)
x<-runif(npoints,0,1)

png("./metacommunity.png",width=1366,height=768);
	par(bg = "black")
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors,type="n")
	rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col = "black")
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors,pch=19)
#	box();
dev.off();



png("./multitrophicmetacommunity.png",width=1366,height=768);
	par(bg = "black")
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors,type="n")
	rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col = "black")
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors,pch=19)
	
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
			lines(x[subsample],y[subsample],col="lightgray",lwd=2)
	
			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
#	box();
dev.off();


png("./multitrophicmetacommunity_staticlandscape.png",width=1366,height=768);
	par(bg = "black")
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors,type="n")
	rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col = "black")
	plot(x,y,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)

	percent<-0.2;
	ymin<-0
	ymax<-0.1
	lines(x=c(0,1),y=c(ymin,ymin),col="white");	
	while(ymax <= 1){
		xmin<-0
		xmax<-0.1
		lines(x=c(xmin,xmin),y=c(0,1),col="white");	
		while(xmax <= 1){
			yrange<-which((y>ymin) & (y<ymax))
			xrange<-which((x>xmin) & (x<xmax))
			xyrange<-intersect(xrange,yrange)
			subsample<-sample(xyrange,percent*length(xyrange))
			lines(x[subsample],y[subsample],col="lightgray",lwd=2)
			lines(x=c(xmax,xmax),y=c(0,1),col="white");	
			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		lines(x=c(0,1),y=c(ymax,ymax),col="white");	
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
#	box();
dev.off();

png("./multitrophicmetacommunity_dynamiclandscape_1.png",width=800,height=800);
	auxx<-x;auxy<-y;
	t1<-which(  ((auxx>0.9)&(auxx<1.0)) & ((auxy>0.0)&(auxy<0.1))  )
	targetsites<-t1;
	auxx<-auxx[-targetsites]
	auxy<-auxy[-targetsites]
	plot(auxx,auxy,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)
	
	percent<-0.2;
	ymin<-0
	ymax<-0.1
	lines(x=c(0,0.9),y=c(ymin,ymin));	
	while(ymax <= 1){
		xmin<-0
		xmax<-0.1
		lines(x=c(xmin,xmin),y=c(0,1));	
		while(xmax <= 1){
			yrange<-which((auxy>ymin) & (auxy<ymax))
			xrange<-which((auxx>xmin) & (auxx<xmax))
			xyrange<-intersect(xrange,yrange)
			subsample<-sample(xyrange,percent*length(xyrange))
			lines(auxx[subsample],auxy[subsample])
			lines(x=c(xmin,xmin),y=c(0,1));	
			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		lines(x=c(xmin,xmin),y=c(0.1,1));	
		lines(x=c(0,1),y=c(ymax,ymax));	
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
#	box();
dev.off();

png("./multitrophicmetacommunity_dynamiclandscape_2.png",width=800,height=800);
	auxx<-x;auxy<-y;
	t1<-which(  ((auxx>0.9)&(auxx<1.0)) & ((auxy>0.0)&(auxy<0.1))  )
	t2<-which(  ((auxx>0.8)&(auxx<0.9)) & ((auxy>0.0)&(auxy<0.1))  )
	targetsites<-c(t1,t2);
	auxx<-auxx[-targetsites]
	auxy<-auxy[-targetsites]
	plot(auxx,auxy,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)
	
	percent<-0.2;
	ymin<-0
	ymax<-0.1
	lines(x=c(0,0.8),y=c(ymin,ymin));	
	while(ymax <= 1){
		xmin<-0
		xmax<-0.1
		lines(x=c(xmin,xmin),y=c(0,1));	
		while(xmax <= 1){
			yrange<-which((auxy>ymin) & (auxy<ymax))
			xrange<-which((auxx>xmin) & (auxx<xmax))
			xyrange<-intersect(xrange,yrange)
			subsample<-sample(xyrange,percent*length(xyrange))
			lines(auxx[subsample],auxy[subsample])
			if(xmin <= 0.8){lines(x=c(xmin,xmin),y=c(0,1));}	
			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		lines(x=c(0,1),y=c(ymax,ymax));	
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
	lines(x=c(0.9,0.9),y=c(0.1,1));	
	lines(x=c(1,1),y=c(0.1,1));	
#	box();
dev.off();



png("./multitrophicmetacommunity_dynamiclandscape_3.png",width=800,height=800);
	auxx<-x;auxy<-y;
	t1<-which(  ((auxx>0.9)&(auxx<1.0)) & ((auxy>0.0)&(auxy<0.1))  )
	t2<-which(  ((auxx>0.8)&(auxx<0.9)) & ((auxy>0.0)&(auxy<0.1))  )
	t3<-which(  ((auxx>0.9)&(auxx<1.0)) & ((auxy>0.1)&(auxy<0.2))  )
	targetsites<-c(t1,t2,t3);
	auxx<-auxx[-targetsites]
	auxy<-auxy[-targetsites]
	plot(auxx,auxy,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)
	
	percent<-0.2;
	ymin<-0
	ymax<-0.1
	lines(x=c(0,0.8),y=c(ymin,ymin));	
	while(ymax <= 1){
		xmin<-0
		xmax<-0.1
		lines(x=c(xmin,xmin),y=c(0,1));	
		while(xmax <= 1){
			yrange<-which((auxy>ymin) & (auxy<ymax))
			xrange<-which((auxx>xmin) & (auxx<xmax))
			xyrange<-intersect(xrange,yrange)
			subsample<-sample(xyrange,percent*length(xyrange))
			lines(auxx[subsample],auxy[subsample])
			if(xmin <= 0.8){lines(x=c(xmin,xmin),y=c(0,1));}	
			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		if(ymax > 0.1) {lines(x=c(0,1),y=c(ymax,ymax));}	
		if(ymax == 0.1){lines(x=c(0,0.9),y=c(ymax,ymax));}
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
	lines(x=c(0.9,0.9),y=c(0.1,1));	
	lines(x=c(1,1),y=c(0.2,1));	
#	box();
dev.off();


png("./multitrophicmetacommunity_dynamiclandscape_4.png",width=800,height=800);
	auxx<-x;auxy<-y;
	t1<-which(  ((auxx>0.9)&(auxx<1.0)) & ((auxy>0.0)&(auxy<0.1))  )
	t2<-which(  ((auxx>0.8)&(auxx<0.9)) & ((auxy>0.0)&(auxy<0.1))  )
	t3<-which(  ((auxx>0.9)&(auxx<1.0)) & ((auxy>0.1)&(auxy<0.2))  )
	t4<-which(  ((auxx>0.7)&(auxx<0.9)) & ((auxy>0.1)&(auxy<0.3))  )
	targetsites<-c(t1,t2,t3,t4);
	auxx<-auxx[-targetsites]
	auxy<-auxy[-targetsites]
	plot(auxx,auxy,xlim=c(0,1),ylim=c(0,1),axes=F,xlab="",ylab="",col=colors)
	
	percent<-0.2;
	ymin<-0
	ymax<-0.1
	lines(x=c(0,0.8),y=c(ymin,ymin));	
	while(ymax <= 1){
		xmin<-0
		xmax<-0.1
		lines(x=c(xmin,xmin),y=c(0,1));	
		while(xmax <= 1){
			yrange<-which((auxy>ymin) & (auxy<ymax))
			xrange<-which((auxx>xmin) & (auxx<xmax))
			xyrange<-intersect(xrange,yrange)
			subsample<-sample(xyrange,percent*length(xyrange))
			lines(auxx[subsample],auxy[subsample])
			if(xmin <= 0.7){lines(x=c(xmin,xmin),y=c(0,1));}	
			if(!(xmin%%0.8)){
				lines(x=c(xmin,xmin),y=c(0,0.1));
				lines(x=c(xmin,xmin),y=c(0.3,1));
			}
			if((xmin > 0.8)&(xmin < 1.1)){
				lines(x=c(xmin,xmin),y=c(0.2,1));
			}	

			xmin<-xmax;
			xmax<-xmax+0.1;
		}
		if(ymax >= 0.3){lines(x=c(0,1),y=c(ymax,ymax));}	

		if((ymax > 0.1)&(ymax < 0.3)){
			lines(x=c(0,0.7),y=c(ymax,ymax));
			lines(x=c(0.9,1.0),y=c(ymax,ymax));
		}
		if((ymax > 0.)&(ymax < 0.2)){
			lines(x=c(0,0.8),y=c(ymax,ymax));
		}
		ymin<-ymax;
		ymax<-ymax+0.1;
	}
	lines(x=c(1,1),y=c(0.2,1));
	lines(x=c(0.8,0.8),y=c(0,0.1));
	lines(x=c(0.8,0.8),y=c(0.3,1));

#	box();
dev.off();

