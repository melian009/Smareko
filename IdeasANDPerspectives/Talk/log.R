source("./imagescale.R")

pal.1=colorRampPalette(c("yellow","red","orange"), space="rgb")

png("Example_PhaseSpace.png",width=1366,height=768);
layout(matrix(c(1,2), nrow=2, ncol=1), widths=c(5,5), heights=c(5,1))
layout.show(2)

# Optimization problem with many extrema: non-linear regression
#   y = sin( a * x + b ) + noise
n <- 100
x <- seq(0,1,length=n)
f <- function(x,a,b) sin(a*x+b)
y <- f(x, 4*pi*runif(1), 2*pi*runif(1)) + rnorm(n)
g <- function(a,b) sum((f(x,a,b) - y)^2)
N <- 100
a <- seq(0, 10*pi, length=N)
b <- seq(0,  2*pi, length=N)*100;
z <- outer(a, b, Vectorize(g))
image(a, b, z, las=1, main="Gamma Diversity", xlab="Prob DL", ylab="Mean Radius",xaxt="n");
axis(1, at=seq(a[1],a[length(a)],by=5),labels=FALSE);
text(seq(a[1],a[length(a)],by=5),par("usr")[3], labels = signif(seq(a[1],a[length(a)],by=5)/(10*pi),2), pos = 1, xpd = TRUE)

breaks <- seq(min(z), max(z),length.out=100)
par(mar=c(3,1,1,1));
image.scale(z, col=pal.1(length(breaks)-1), breaks=breaks, horiz=TRUE);
dev.off();



