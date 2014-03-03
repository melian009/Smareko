%---------------------------------------------------------------
%Multitrophic metacommunities in dynamic landscapes
%assumptions: Rgn with sinusoidal-variable threshold 
%+ multitrophic dynamics with ecological drift
%Feb-Mar 2014
%De Santana, Klecka and Melian (2014)
%---------------------------------------------------------------
for ri = 1:100;
G = unidrnd(1000,1,1);%Generations could be variable
s = rand;%prob to be a static landscape
S = 100;J = 100;%S sites and J inds. per site
%Resources
newspeciesR = 1;R = ones(S,J);mr = unifrnd(0.2,0.7,1);vr = unifrnd(0.1,0.5,1);
%Consumers
newspeciesH = 1;H = ones(S,J);mh = unifrnd(0.2,0.7,1);vh = unifrnd(0.1,0.5,1);
%Predators
newspeciesP = 1;P = ones(S,J);mp = unifrnd(0.2,0.7,1);vp = unifrnd(0.1,0.5,1);

%initial random geometric generator

%r = unifrnd(10,700);%random landscape: r uniform 10 (all isolated sites),700 (all connected sites)
A = 350;%amplitude, is the peak deviation: 350 to match simulations in random landscapes
f = 0.01;%ordinary frequency, number of cycles that occur each second of time
sig = 0;%the phase
r = A*sin(2*pi*f*A + sig) + A;%starting point with r approx. A

D = zeros(S,S);%threshold matrix
Di = zeros(S,S);%distance matrix
%mu = S*(e^(-pi * (r/1000)^2 * S));%site connectivity
mu = S*(exp((-pi * (r/1000)^2 * S)));%site connectivity
n = unifrnd(0,1000,S,2);%geographic coordinates for S sites for a 1000kmx1000km landscape
  for i = 1:S-1;
      for j = i+1:S;
          A = (n(i,1) - n(j,1))^2;%Euclidean distance
          B = (n(i,2) - n(j,2))^2;
          d(i,j) = sqrt(A + B);
          Di(i,j) = 1/d(i,j);%distance matrix
          if d(i,j) < r;%threshold
             D(i,j) = 1;
          else
             D(i,j) = 0;
          end
      end
  end
  DI=Di+Di';Dc=cumsum(DI,2);D1=D+D';cdynamics = 0;
  
for k = 1:G;%population-metapopulation-metacommunity dynamics (not-tracking multitrophic metacommunity dynamics!)
     if rand > s;%landscape dynamic: rgn
        cdynamics = cdynamics + 1;
        %r = unifrnd(10,700);%random landscape: r uniform 10 (all isolated sites),700 (all connected sites)
        A = 350;%amplitude, is the peak deviation: 350 to match simulations in random landscapes
        f = 0.01;%ordinary frequency, number of cycles that occur each second of time
        sig = 0;%the phase
        r = A*sin(2*pi*f*A + sig) + A;%starting point with r approx. A
       
        D = zeros(S,S);%theshold matrix
        Di = zeros(S,S);%distance matrix
        %mu = S*(e^(-pi * (r/1000)^2 * S));%site connectivity
        mu = S*(exp((-pi * (r/1000)^2 * S)));%site connectivity
        n = unifrnd(0,1000,S,2);
        for i = 1:S-1;
            for j = i+1:S;
                A = (n(i,1) - n(j,1))^2;%Euclidean distance
                B = (n(i,2) - n(j,2))^2;
                d(i,j) = sqrt(A + B);
                Di(i,j) = 1/d(i,j);
                if d(i,j) < r;%threshold
                   D(i,j) = 1;
                else
                   D(i,j) = 0;
                end
           end
        end
        DI=Di+Di';Dc=cumsum(DI,2);D1=D+D';
        %checking plot all same color
        %gplot(D1,n, "k.-")
        %set (get (gca, ("children")), "markersize", 12);
     end%rand   
        for j = 1:S*J;
            %R
            KillHab = unidrnd(S);KillInd = unidrnd(J);mvb = unifrnd(0,1);
            if mvb <= mr;MigrantHab = unifrnd(0,max(Dc(KillHab,:)));
               for kr = 1:S;
                   if Dc(KillHab,kr) >= MigrantHab && D1(KillHab,kr) == 1;MigrantInd = unidrnd(J);
                      R(KillHab,KillInd) = R(kr,MigrantInd);
                   end
                   break
               end
            elseif mvb > mr && mvb <= mr+vr;newspeciesR = newspeciesR + 1;
               R(KillHab,KillInd) = newspeciesR;                                       
            else
               BirthLocal = unidrnd(J);
               if BirthLocal ~= KillInd;
                  R(KillHab,KillInd) = R(KillHab,BirthLocal);
               end
            end
            %C
            KillHab = unidrnd(S);KillInd = unidrnd(J);mvb = unifrnd(0,1);
            if mvb <= mh;MigrantHab = unifrnd(0,max(Dc(KillHab,:)));
               for kc = 1:S;
                   if D(KillHab,kc) >= MigrantHab && D1(KillHab,kc) == 1;MigrantInd = unidrnd(J);
                      H(KillHab,KillInd) = H(kc,MigrantInd);
                   end
                   break
               end
            elseif mvb > mh && mvb <= mh+vh;newspeciesH = newspeciesH + 1;
               H(KillHab,KillInd) = newspeciesH;                                       
            else
               BirthLocal = unidrnd(J);
               if BirthLocal ~= KillInd
                  H(KillHab,KillInd) = H(KillHab,BirthLocal);   
               end
            end
            %P
            KillHab = unidrnd(S);KillInd = unidrnd(J);mvb = unifrnd(0,1);
            if mvb <= mp;MigrantHab = unifrnd(0,max(Dc(KillHab,:)));
               for kp = 1:S;
                   if D(KillHab,kp) >= MigrantHab && D1(KillHab,kc) == 1;MigrantInd = unidrnd(J);
                      P(KillHab,KillInd) = P(kp,MigrantInd);
                   end
                   break
               end
            elseif mvb > mp && mvb <= mp+vp;newspeciesP = newspeciesP + 1;
               P(KillHab,KillInd) = newspeciesP;                                       
            else
               BirthLocal = unidrnd(J);
               if BirthLocal ~= KillInd
                  P(KillHab,KillInd) = P(KillHab,BirthLocal);   
               end
            end
        end%SJ
        r_randomdynamics(k,1) = r;
end%G

  %gamma richness
  for i = 1:S;
      %C = unifrnd(0.02,0.24);%think about implementation
      AR = sort(R(i,:));extantspeciesR = [ find(AR(1:end-1) ~= AR(2:end)) length(AR) ];richnessR = AR(extantspeciesR);
      abuR = diff([0 extantspeciesR]);abuR = sort(abuR,'descend');
      extantR = length(richnessR);

      AH = sort(H(i,:));extantspeciesH = [ find(AH(1:end-1) ~= AH(2:end)) length(AH) ];richnessH = AH(extantspeciesH);
      abuH = diff([0 extantspeciesH]);abuH = sort(abuH,'descend');
      extantH = length(richnessH);

      AP = sort(P(i,:));extantspeciesP = [ find(AP(1:end-1) ~= AP(2:end)) length(AP) ];richnessP = AP(extantspeciesP);
      abuP = diff([0 extantspeciesP]);abuP = sort(abuP,'descend');
      extantP = length(richnessP);
  end
  RHPgamma = extantR + extantH + extantP;
  %random dynamic landscape
  Vr_rd =  var(r_randomdynamics);
  Mr_rd =  mean(r_randomdynamics);
fid = fopen('StaticDynamicLandscapes.txt','a');fprintf(fid,'%3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f %3f\n',G,s,cdynamics/G,S,J,vr,mr,vh,mh,vp,mp,extantR,extantH,extantP,RHPgamma,Vr_rd,Mr_rd);fclose(fid);
end%ri




