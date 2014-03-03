source("./log.R")
palette(colors,range(gamma)[1],range(gamma)[2],gamma[1])
colors
test<-1:20
plot(test,test,pch=test)
savehistory("./log2.R")
