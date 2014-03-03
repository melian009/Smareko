%for t = 1:1000;%min 10;max 700;mean 300
%    A = 10;%amplitude, is the peak deviation
%    f = 0.01;%ordinary frequency, number of cycles that occur each second of time
%    sig = 0;%the phase
%    y(t,2) = A*sin(2*pi*f*t + sig) + A;
%    y(t,1) = t;
%end
%plot(y(:,1),y(:,2),'k')

for t = 1:1000;%min 10;max 700;mean 300
    A = 4;%amplitude, is the peak deviation
    f = 2;%ordinary frequency, number of cycles that occur each second of time
    sig = 0;%the phase
    y(t,2) = A*sin(2*pi*f*t + sig);
    y(t,1) = t;
end
plot(y(:,1),y(:,2),'k')
