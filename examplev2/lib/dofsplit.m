function [ux, uy, uz] = dofsplit(u)
n=size(u,1)/3;
ux=u(1:3:3*n);
uy=u(2:3:3*n);
uz=u(3:3:3*n);
if nargout == 1
    ux = [ux uy uz];
end
end