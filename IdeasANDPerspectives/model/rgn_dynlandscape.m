%RGG %Quick code Carlos J Melian
%November 2013


J = 100;S = 100;
%r = 0.1;%r = unifrnd(0.01,1);
D = zeros(J,J);

for t = 1:1000;
%asymptotic behavior with yn landscapes
A = 100;%for 0,1coordinates;0.05;%amplitude, is the peak deviation
f = 0.01;%ordinary frequency, number of cycles that occur each second of time
sig = 0;%the phase
r = A*sin(2*pi*f*t + sig) + A
%y(t,1) = t;
mu = S*(exp((-pi * (r/1000)^2 * S)))%site connectivity
n = unifrnd(0,1000,S,2);%geographic coordinates for S sites for a 1000kmx1000km landscape
  for i = 1:S-1;
      for j = i+1:S;
          A = (n(i,1) - n(j,1))^2;%Euclidean distance
          B = (n(i,2) - n(j,2))^2;
          d(i,j) = sqrt(A + B);
          if d(i,j) < r;%threshold
             D(i,j) = 1;
          else
             D(i,j) = 0;
          end
      end
  end
  %DI=Di+Di';Dc=cumsum(DI,2);
D1=D+D';%cdynamics = 0;

%Asymptotic behavior
%mu = J*(e^(-pi * r^2 * J))
%MA = log(J) - log(mu);
%MB = pi*J;
%rc = sqrt(MA/MB);


%n = unifrnd(0,1,J,2);
%for i = 1:J-1;
%     for j = i+1:J;
%         A = (n(i,1) - n(j,1))^2;%Euclidean distance
%         B = (n(i,2) - n(j,2))^2;
%         d(i,j) = sqrt(A + B);
%         if d(i,j) < r;
%            D(i,j) = 1;
%         else
%            D(i,j) = 0;
%         end
%     end
%end
%D1=D+D';

%plot network
gplot(D1,n, "r.-")
set (get (gca, ("children")), "markersize", 12);
%giant component
[blocks,dag] = components(D1);AT = sort(blocks);
connectivity = [ find(AT(1:end-1) ~= AT(2:end)) length(AT) ];
numberclusters = AT(connectivity);
sizeclusters = diff([0 connectivity]);
max(sizeclusters)
pause
end
