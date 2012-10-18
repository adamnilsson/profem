% file='Analysis1.ans'
%   n = total dofs
%   x = 3d-point or x-component of point
%   y = y-component of point
%   z = z-component of point
function [U, LN] = parseDisp(filename,n,x,y,z)
if nargin == 3
    y=x(2);
    z=x(3);
    x=x(1);
end
DX=[];
DY=[];
DZ=[];
fid = fopen(filename);
U=sparse(n,6);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    tdata = regexp(tline,'\,','split');
    if strcmp(tdata(1),'D')
        i = str2double(cell2mat(tdata(2)));
        if strcmp(tdata(3),'UX')
            DX = [DX; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'UY')
            DY = [DY; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'UZ')
            DZ = [DZ; i str2double(cell2mat(tdata(4)))];
        end
    end
end
nd = size(DX,1);
D=zeros(nd,4);
D(:,1)=DX(:,1);
D(:,2)=DX(:,2)-x;
D(:,3)=DY(:,2)-y;
D(:,4)=DZ(:,2)-z;
for p=1:nd
    U(D(p,1)*3-[2 1 0],1:3)=eye(3);
    U(D(p,1)*3-[2 1 0],4:6)=[0 D(p,4) -D(p,3); -D(p,4) 0 D(p,2); D(p,3) -D(p,2) 0];
end
fclose(fid);
LN=zeros(3*nd,1);
LN(1:3:3*nd)=DX(:,1)*3-2;
LN(2:3:3*nd)=DY(:,1)*3-1;
LN(3:3:3*nd)=DZ(:,1)*3;