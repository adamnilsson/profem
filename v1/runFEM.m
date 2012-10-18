
function [u, sigma_nod, K, N, EN] = runFEM(filename, dampl, outname, K)
disp(['Starting analysis: ' filename]);
disp('Parsing ansys-file ...');
[N, EN, MAT, Fb, bc,D] = ansysparser(filename);


if ~exist('K','var')
    disp('Generating K-matrix ...');
    K = getK3(EN,N,MAT,D);
    save('lastK','K');
    disp('Generating K-matrix Done');
else
    disp('Using old K-matrix');
end
% disp('Extracting submatrix...');
% Ks = extractSub('C:\Users\work\Documents\bearing analysis\beam_end\beam_end.ans',K,Fb,bc,size(K,1),0,0,1000)


disp('Solving system ...');
a = solveq(K,Fb,bc);
disp('Solved');
n=size(N,1);
ux=a(1:3:3*n);
uy=a(2:3:3*n);
uz=a(3:3:3*n);

u = [ux uy uz];

% disp('Ploting displacement.');
% figure(1)
% eldisp3(EN,N,u,dampl)
% axis equal;
% colorbar();
% title('Displacement (mm)');
% xlabel('x (mm)');
% ylabel('y (mm)');
% zlabel('z (mm)');

disp('Extracting coordinates ...');
[edof3, dof]=translate3d(EN);
ed = extract(edof3,a);
for i = 1:size(edof3,1)
    ex(i,:) = N(EN(i,2:5),1)';
    ey(i,:) = N(EN(i,2:5),2)';
    ez(i,:) = N(EN(i,2:5),3)';
end

disp('Calculating stress ..');
vMs = zeros(size(ex,1),1);
for i=1:size(ex,1)
    [astress, astrain] = soli4s(ex(i,:), ey(i,:), ez(i,:), D(:,:,MAT(i,2)), ed(i,:));
    stress(i,:)=astress;
    vMs(i,1) = sign(prod(astrain(1:3)))*vMstress(astress);
end
% disp('Calculating von Mises stress ...');
% vMs = vMstress(stress);
sigma_nod = zeros(n,1);
for i = 1:n
    [c0,c1] = find(EN(:,2:5)==i);
    sigma_nod(i,1) = sum(vMs(c0))/size(c0,1);
end
disp('done');
% disp('Ploting stress');
% figure(2)
% fs = eldraw3(EN,N,sigma_nod)
% colorbar();
% title('von Mises Stress (MPa)');
% xlabel('x (mm)');
% ylabel('y (mm)');
% zlabel('z (mm)');
% axis equal;
if exist('outname','var')
    save(outname,'u','sigma_nod','EN','N','K');
end
showResult(u, sigma_nod, N, EN,dampl)

disp('Analysis Done.');