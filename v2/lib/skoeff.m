%% Fourierkoefficients for sinus terms
%  b = skoeff(f,t,n)
% 
%  f = discretisation of function to expand.
%  t = timepoints corresponding to values of f.
%  n = number of fourier terms to calculate.
% 
% Output
%  b = koefficients.
% 
% Adam Nilsson, 2011
function b = skoeff(f,t,n)
L=max(t)-min(t);
Omg = pi/L;
b = zeros(1,n);
for k=1:n
b(k) = 1/L*sum(conv(sin(k*Omg*t).*f,[.5 .5],'valid').*diff(t));
end
