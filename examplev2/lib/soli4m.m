function [Me] = soli4e(ex, ey, ez, rho)
load PMat
J=[ex(1,2:4)-ex(1,1); ey(1,2:4)-ey(1,1); ez(1,2:4)-ez(1,1)];
Me = PMat*det(J)*rho;