%% Fourierkoefficients for cosinus terms
%  b = ckoeff(f,t,n)
% 
% Input
%  f = discretisation of function to expand.
%  t = timepoints corresponding to values of f.
%  n = number of fourier terms to calculate.
% 
% Output
%  a = koefficients.
%  c = zero frequency koefficient.
% 
% Adam Nilsson, 2011
function [a, c] = ckoeff(f,t,n)
L=max(t)-min(t);
Omg = pi/L;
a = zeros(1,n);
for k=1:n
a(k) = 1/L*sum(conv(cos(k*Omg*t).*f,[.5 .5],'valid').*diff(t));
end
c = sum(conv(f,[.5 .5],'valid').*diff(t))/(2*L);