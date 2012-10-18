function [edof3, dof] = translate3d(edof, coord)

t=size(edof,1);
edof3 = zeros(t,13);
edof3(:,1) = 1:t;
edof3(:,[2 5 8 11]) = edof(:,[2 3 4 5])*3-2;
edof3(:,[3 6 9 12]) = edof(:,[2 3 4 5])*3-1;
edof3(:,[4 7 10 13]) = edof(:,[2 3 4 5])*3;
dof=[1:2:2*t; 2:2:2*t]';
end