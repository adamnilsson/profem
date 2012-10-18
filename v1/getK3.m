function K = getK3(edof, coord, MAT, D)
K=sparse(size(coord,1)*3,size(coord,1)*3);
edof3=translate3d(edof);
t=size(edof,1);
wb=waitbar(0,'Setup K-matrix');
for i = 1:t
    waitbar(i/t);
    ex = coord(edof(i,2:5),1)';
    ey = coord(edof(i,2:5),2)';
    ez = coord(edof(i,2:5),3)';
    K(edof3(i,2:13),edof3(i,2:13)) = K(edof3(i,2:13),edof3(i,2:13)) + soli4e(ex,ey,ez,D(:,:,MAT(i,2)));
end
close(wb)
end