function H = eldraw3(edof, coord, stress, elnum)
%   plotpar = []
if exist('elnum','var') && strcmp(elnum, 'solid')
    face = zeros(size(edof,1)*4,3);
else
    face = zeros(size(edof,1),10);
end
ecent = zeros(size(edof,1),3);
for i = 1:size(edof,1)


if exist('elnum','var') && strcmp(elnum, 'solid')
    face(i*4-3,:) = edof(i,[5 3 2]);
    face(i*4-2,:) = edof(i,[5 4 3]);
    face(i*4-1,:) = edof(i,[5 2 4]);
    face(i*4,:) = edof(i,[4 3 2]);
else
    face(i,:) = edof(i,[2 3 4 2 5 4 3 5 2 3]);
end

if exist('elnum','var') && ~strcmp(elnum, 'solid')
    ecent(i,:) = sum(coord(edof(i,2:5),:))/4;
    text(ecent(i,1),ecent(i,2),ecent(i,3),int2str(elnum(i)));
end
% [edof(i,[1 2 3]); edof(i,[1 2 4]); edof(i,[2 3 4]); edof(i,[3 1 4])];
end


% ,'EdgeColor','interp','FaceVertexCData',Cdata2 för färg
H=patch('Vertices',coord,'Faces',face,'FaceColor','none','linewidth',1)
if exist('stress','var')
    set(H,'EdgeColor','interp')
    set(H,'FaceVertexCData',stress);
end
if exist('elnum','var')
    if strcmp(elnum, 'solid')
        set(H,'FaceColor','interp')
        set(H,'EdgeColor','black')
    end
end