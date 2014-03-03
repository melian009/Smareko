files<-c("randomlanscapes_lowmigrationpool_highmigration.txt","randomlanscapes_lowmigrationpool_lowmigration.txt","randomlanscapes_lowmigrationpool_mediummigration.txt");
i<-2;
dat<-read.csv(files[i],sep=" ",header=FALSE);
G          <-dat[,1];
Prob_SL    <-dat[,2];
Prob_DL    <-dat[,3];
S          <-dat[,4];
J          <-dat[,5];
R_SRP      <-dat[,6];
mig_R      <-dat[,7];
H_SRP      <-dat[,8];
mig_H      <-dat[,9];
P_SRP      <-dat[,10];
mig_P      <-dat[,11];
gammaR     <-dat[,12];
gammaH     <-dat[,13];
gammaP     <-dat[,14];
varRadius  <-dat[,15];
meanRadius <-dat[,16];
gamma<-gammaR+gammaH+gammaP
colors<-c("darkblue","blue","cyan","lightgreen","green","yellow","orange","lightred","red","brown")

palette<-function(colors,min,max,x){
pos<-((x-min)/(max-min))*length(colors);
cat(pos,sep="\n");return(colors[pos]);
}

palette(colors,range(gamma)[1],range(gamma)[2],gamma[1])
c(colors,range(gamma)[1],range(gamma)[2],gamma[1])
