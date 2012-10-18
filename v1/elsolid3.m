function elsolid3(edof, coord, u, magn, offs)
if ~exist('magn','var')
%     us = dofsplit(u);
    magn=norm(max(coord)-min(coord))/max(max(abs(u)))*0.05;
    if magn>1000
        magn=1000;
    end
end
if exist('offs','var')
    dcoord = coord + u*magn + ones(size(coord,1),1)*offs;%/norm(max(u));
else
    dcoord = coord + u*magn;
end
%   plotpar = []
face = zeros(size(edof,1)*4,3);
ecent = zeros(size(edof,1),3);
for i = 1:size(edof,1)
face(i*4-3,:) = edof(i,[5 3 2]);
face(i*4-2,:) = edof(i,[5 4 3]);
face(i*4-1,:) = edof(i,[5 2 4]);
face(i*4,:) = edof(i,[4 3 2]);
if exist('elnum','var')
    ecent(i,:) = sum(dcoord(edof(i,2:5),:))/4;
    text(ecent(i,1),ecent(i,2),ecent(i,3),int2str(elnum(i)));
end
% [edof(i,[1 2 3]); edof(i,[1 2 4]); edof(i,[2 3 4]); edof(i,[3 1 4])];
end


amp = sqrt(sum(u.^2,2));

% 'EdgeColor','interp',,'FaceVertexCData',Cdata2 f�r f�rg
H=patch('Vertices',dcoord,'Faces',face,'FaceColor','interp','linewidth',1,'EdgeColor','black','FaceVertexCData',amp)
title(['Displacement in mm (Amplified ' num2str(magn) ' times)'],'FontWeight','bold')