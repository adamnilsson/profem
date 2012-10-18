f=rand(1,100);
f=conv(f,[.5 .5],'same')
f=conv(f,[.5 .5],'same')
f=conv(f,[.5 .5],'same')
t=linspace(0,1,100);
T=max(t)-min(t);
Omg = pi/T;

for n=10:100;
clf;
hold on;
plot(t,f);
[a, c] = ckoeff(f,t,n);
b = skoeff(f,t,n);

k=1:n;
fs=@(x)sum(a(k).*cos(k*Omg*x)) + sum(b(k).*sin(k*Omg*x)) + c;
% fs=@(x)sum(b(k).*sin(k*Omg*x));
fplot(fs,[0,1],'r')
pause
end