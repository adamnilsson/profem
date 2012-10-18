function [c, K] = fkoeff(f,t,kint)
T=max(t)-min(t);
n=1:length(f);
Omg = i*2*pi/T;
c=[];
K=[];
for k=min(kint):max(kint)
    c = [c sum(conv(exp(k*Omg*t(n)).*f(n),[.5 .5],'valid')./diff(t))/T];
    K = [K k];
end