% file='Analysis1.ans'
function [N, EN, MAT, Fb, bc, D, rho] = ansysparser(filename)

DX=[];
DY=[];
DZ=[];
FX=[];
FY=[];
FZ=[];
fid = fopen(filename);
aMAT = 1;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    tdata = regexp(tline,'\,','split');
    if strcmp(tdata(1),'MP')
        if strcmp(tdata(2),'EX');
            i = str2double(cell2mat(tdata(3)));
            % 2.1 convert from N/mm^2 to N/m^2, 
            E(i)= str2double(cell2mat(tdata(4)))*1e6;
        end
        if strcmp(tdata(2),'DENS');
            i = str2double(cell2mat(tdata(3)));
            % 2.1 convert from ???
            rho(i)= str2double(cell2mat(tdata(4)))*1e6;
        end
        
    end
    if strcmp(tdata(1),'MAT')
        aMAT = str2double(cell2mat(tdata(2)));
    end
    if strcmp(tdata(1),'N')
        i = str2double(cell2mat(tdata(2)));
        N(i,1:3)= [str2double(cell2mat(tdata(3))) str2double(cell2mat(tdata(4))) str2double(cell2mat(tdata(5)))];
    end
    if strcmp(tdata(1),'EN')
        i = str2double(cell2mat(tdata(2)));
        EN(i,1:5)= [str2double(cell2mat(tdata(2))) str2double(cell2mat(tdata(3))) str2double(cell2mat(tdata(4))) str2double(cell2mat(tdata(5))) str2double(cell2mat(tdata(6)))];
        
        MAT(i,:) = [i aMAT];
    end
    if strcmp(tdata(1),'D')
        i = str2double(cell2mat(tdata(2)));
        if strcmp(tdata(3),'ALL')
            DX = [DX; i str2double(cell2mat(tdata(4)))];
            DY = [DY; i str2double(cell2mat(tdata(4)))];
            DZ = [DZ; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'UX')
            DX = [DX; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'UY')
            DY = [DY; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'UZ')
            DZ = [DZ; i str2double(cell2mat(tdata(4)))];
        end
    end
    if strcmp(tdata(1),'F')
        i = str2double(cell2mat(tdata(2)));
        if strcmp(tdata(3),'FX')
            FX = [FX; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'FY')
            FY = [FY; i str2double(cell2mat(tdata(4)))];
        elseif strcmp(tdata(3),'FZ')
            FZ = [FZ; i str2double(cell2mat(tdata(4)))];
        end
    end
end
n=size(N,1);
Fb=zeros(n*3,1);
for i = 1:size(FX)
Fb(FX(i,1)*3-2) = FX(i,2);
end
for i = 1:size(FY)
Fb(FY(i,1)*3-1) = FY(i,2);
end
for i = 1:size(FZ)
Fb(FZ(i,1)*3) = FZ(i,2);
end

% Setup boundary conditions
nd = size(DX,1) + size(DY,1) + size(DZ,1);
bc = [];%zeros(nd,2);

for i = 1:size(DX)
bc = [bc; DX(i,1)*3-2 DX(i,2)];
end
for i = 1:size(DY)
bc = [bc; DY(i,1)*3-1 DY(i,2)];
end
for i = 1:size(DZ)
bc = [bc; DZ(i,1)*3 DZ(i,2)];
end
% D=zeros(6,6,length(E));
for i = 1:length(E)
     D(:,:,i)= hooke(4,E(i),.3)
end
fclose(fid);

% v2 fix, to be abel to use solidworks exported quadratic elements in a
% linear analysis.
% N = N(unique(EN(:,2:5)),:);
% Fb = Fb(unique(EN(:,2:5)),:); % Wrong

% Convert to standard si-units
N=N*1e-3;
Fb=Fb*1e6;
bc(:,2)=bc(:,2)*1e-3;


disp('File parsing done.');