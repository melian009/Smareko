#---------------------------------------------------------------
#Multitrophic metacommunities in dynamic landscapes
#assumptions: Rgn with sinusoidal-variable threshold 
#+ multitrophic dynamics with ecological drift
#Feb-Mar 2014
#De Santana, Klecka and Melian (2014)
#---------------------------------------------------------------
library(igraph)
library(animation)

randomGeomNet


replicate<-10;
#rand('seed',sum(100*clock));
Gmax = 1000;
Xrange = 1000;
Yrange = 1000;
for (ri in 1:replicate){
	G<-runif(1,1,Gmax);#%Generations could be variable
	s<-runif(1,1,Gmax)/Gmax;#prob to be a static landscape
	S<-100;J<-100;#S sites and J inds. per site
	#%Resources
	newspeciesR = 1;R = array(1,dim=c(S,J));mr = runif(1,0.2,0.7);vr = runif(1,0.1,0.5);
	#%Consumers
	newspeciesH = 1;H = array(1,dim=c(S,J));mh = runif(1,0.2,0.7);vh = runif(1,0.1,0.5);
	#%Predators
	newspeciesP = 1;P = array(1,dim=c(S,J));mp = runif(1,0.2,0.7);vp = runif(1,0.1,0.5);
	#initial random geometric generator
	
	#r = unifrnd(10,700);#random landscape: r uniform 10 (all isolated sites),700 (all connected sites)
	A = 100;#amplitude, is the peak deviation: 350 to match simulations in random landscapes
	f = 0.01;#ordinary frequency, number of cycles that occur each second of time
	sig = 0;#the phase
	r = A*sin(2*pi*f*A + sig) + A;#starting point with r approx. A
	
	D = array(0,dim=c(S,S));#threshold matrix
	Di = array(0,dim=c(S,S));#distance matrix
	
	#mu = S*(e^(-pi * (r/1000)^2 * S));#site connectivity
	mu = S*(exp((-pi * (r/Xrange)^2 * S)));#site connectivity
	
	n<-array(0,dim=c(S,2));
	n[,1]<-runif(S,0,Xrange);
	n[,2]<-runif(S,0,Yrange);
	r_randomdynamics = array(0,1);
	for (i in 1:(S-1)){
		for (j in (i+1):S){
			A = (n[i,1] - n[j,1])^2;#Euclidean distance
			B = (n[i,2] - n[j,2])^2;
			D[i,j] = sqrt(A + B);
			Di[i,j] = 1/D[i,j];#distance matrix
			if (D[i,j] < r){#threshold
				D[i,j] = 1;}
			else{
				D[i,j] = 0;
			}	
		}
	}
#To plot the landscape network
	png(paste("./Landscape_",ri,".png",sep=""),width=1366,height=768);
	plot(graph.adjacency(as.matrix(D)),vertex.size=0.001,vertex.label="",edge.arrow.size=0,edge.color="red",layout=as.matrix(n));
	dev.off();
	
	DI=t(Di+Di);
	Dc<-DI;
	for (i in 1:length(Dc[,1])){
		Dc[i,]<-cumsum(DI[i,]);
	}
	D1=t(D+D);
	cdynamics = 0;
	countgen=0; 
	for (k in 1:G){#population-metapopulation-metacommunity dynamics (not-tracking multitrophic metacommunity dynamics!)
	     if (runif(1,0,1) > s){#landscape dynamic: rgn
	        cdynamics = cdynamics + 1;

		D = array(0,dim=c(S,S));#theshold matrix
	        Di = array(0,dim=c(S,S));#distance matrix
	
	        #r = unifrnd(10,700);#random landscape: r uniform 10 (all isolated sites),700 (all connected sites)
	        A = 100;#amplitude, is the peak deviation: 350 to match simulations in random landscapes
	        f = 0.01;#ordinary frequency, number of cycles that occur each second of time
	        sig = 0;#the phase
	        countgen = countgen + 1;
	        r = A*sin(2*pi*f*countgen + sig) + A;#starting point with r approx. A and countgen is generation season
	       	#mu = S*(e^(-pi * (r/1000)^2 * S));#site connectivity
	        mu = S*(exp((-pi * (r/1000)^2 * S)));#site connectivity
		n[,1]<-runif(S,0,1000);
		n[,2]<-runif(S,0,1000);

	        for (i in 1:(S-1)){
	            for (j in (i+1):S){
	                A = (n[i,1] - n[j,1])^2;#Euclidean distance
	                B = (n[i,2] - n[j,2])^2;
	                D[i,j] = sqrt(A + B);
	                Di[i,j] = 1/D[i,j];
	                if (D[i,j] < r){#threshold
	                   D[i,j] = 1;}
	                else{
	                   (D[i,j] = 0)
			}
	          } 
	        }
	        DI=t(Di+Di);
		Dc<-DI;
		for (i in 1:length(Dc[,1])){
			Dc[i,]<-cumsum(DI[i,]);
		}
		D1=t(D+D);
	     }#rand  
 
		for (j in 1:(S*J)){
			#R
			KillHab = runif(1,1,S);KillInd = runif(1,1,J);mvb = runif(1,0,1);
			if (mvb <= mr){
				MigrantHab = runif(1,0,max(Dc[KillHab,]));
				for (kr in 1:S){
					if ( (Dc[KillHab,kr] >= MigrantHab) && (D1[KillHab,kr] == 1)){
						MigrantInd = runif(1,0,J);
						R[KillHab,KillInd] = R[kr,MigrantInd];
					} 
				}
			}
			else if ( (mvb > mr) && (mvb <= mr+vr)){
				newspeciesR = newspeciesR + 1;
				R[KillHab,KillInd] = newspeciesR;                                       
			}
			else{
				BirthLocal = runif(1,1,J);
				if (BirthLocal != KillInd){
					R[KillHab,KillInd] = R[KillHab,BirthLocal];
				}
			}
		
			#C
		       	KillHab = runif(1,1,S);KillInd = runif(1,1,J);mvb = runif(1,0,1);
			if (mvb <= mh){
				MigrantHab = runif(1,0,max(Dc[KillHab,]));
				for (kc in 1:S){
					if ( (Dc[KillHab,kc] >= MigrantHab) && (D1[KillHab,kc] == 1)){
						MigrantInd = runif(1,0,J);
						H[KillHab,KillInd] = H[kc,MigrantInd];
					} 
				}
			}
			else if ( (mvb > mh) && (mvb <= mh+vh)){
				newspeciesH = newspeciesH + 1;
				H[KillHab,KillInd] = newspeciesH;                                       
			}
			else{
				BirthLocal = runif(1,1,J);
				if (BirthLocal != KillInd){
					H[KillHab,KillInd] = H[KillHab,BirthLocal];
				}
			}
		
		
		
			#P
		       	KillHab = runif(1,1,S);KillInd = runif(1,1,J);mvb = runif(1,0,1);
			if (mvb <= mp){
				MigrantHab = runif(1,1,max(Dc[KillHab,]));
				for (kc in 1:S){
					if ( (Dc[KillHab,kc] >= MigrantHab) && (D1[KillHab,kc] == 1)){
						MigrantInd = runif(1,0,J);
						P[KillHab,KillInd] = P[kc,MigrantInd];
					} 
				}
			}
			else if ( (mvb > mp) && (mvb <= mp+vp)){
				newspeciesP = newspeciesP + 1;
				P[KillHab,KillInd] = newspeciesP;                                       
			}
			else{
				BirthLocal = runif(1,1,J);
				if (BirthLocal != KillInd){
					P[KillHab,KillInd] = P[KillHab,BirthLocal];
				}
			}
		
	        }#SJ
	        r_randomdynamics[k] = r;
	}#G
	
	#gamma richness
	#for (i in 1:S){
	#	#C = unifrnd(0.02,0.24);#think about implementation
	#	AR = sort(R[i,]);extantspeciesR = which(AR[1:(end-1)] != AR[2:end]);richnessR = AR[extantspeciesR];
	#	abuR = diff([0 extantspeciesR]);abuR = sort(abuR,'descend');
	#	extantR = length(richnessR);
	#	
	#	AH = sort(H(i,:));extantspeciesH = [ find(AH(1:end-1) ~= AH(2:end)) length(AH) ];richnessH = AH(extantspeciesH);
	#	abuH = diff([0 extantspeciesH]);abuH = sort(abuH,'descend');
	#	extantH = length(richnessH);
	#	
	#	AP = sort(P(i,:));extantspeciesP = [ find(AP(1:end-1) ~= AP(2:end)) length(AP) ];richnessP = AP(extantspeciesP);
	#	abuP = diff([0 extantspeciesP]);abuP = sort(abuP,'descend');
	#	extantP = length(richnessP);
	#}
	#  RHPgamma = extantR + extantH + extantP;
	#  #random dynamic landscape
	#  Vr_rd =  var(r_randomdynamics);
	#  Mr_rd =  mean(r_randomdynamics);
	#fid = fopen('StaticDynamicLandscapes.txt','a');fprintf(fid,'#3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f #3f\n',G,s,cdynamics/G,S,J,vr,mr,vh,mh,vp,mp,extantR,extantH,extantP,RHPgamma,Vr_rd,Mr_rd);fclose(fid);
	#end#ri
	#
	#
	#
	#
	#
}
