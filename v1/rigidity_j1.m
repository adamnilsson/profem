path = 'H:\Users\adam\Documents\t2\'

J1 = element;


filename = [path '\t1-proe\rigidity_j1\rigidity_j1.ans'];
disp(['Starting analysis: ' filename]);
disp('Parsing ansys-file ...');
[N, EN, MAT, Fb, bc,D] = ansysparser(filename);

% 
% if ~exist('K','var')
    disp('Generating K-matrix ...');
    K = getK3(EN,N,MAT,D);
    save('lastK','K');
    disp('Generating K-matrix Done');
% else
%     disp('Using old K-matrix');
% end
% disp('Extracting submatrix...');
% Ks = extractSub('C:\Users\work\Documents\bearing analysis\beam_end\beam_end.ans',K,Fb,bc,size(K,1),0,0,1000)

J1.fullK=K;

n=size(K,1);
[U1, LN1] = parseDisp([path '\t1-proe\rigidity_j1_pnt1\rigidity_j1_pnt1.ans'],n,-93,35,0);

Ks = zeros(4,4);
    bc2=[bc; LN1 U1(LN1,:)*[1 0 0 0 0 0]';];
    a = solveq(K,Fb,bc2);
    Ks(1:4,1) = U1(:,[1 3 4 6])'*K*a;
    bc2=[bc; LN1 U1(LN1,:)*[0 0 1 0 0 0]';];
    a = solveq(K,Fb,bc2);
    Ks(1:4,2) = U1(:,[1 3 4 6])'*K*a;
    bc2=[bc; LN1 U1(LN1,:)*[0 0 0 1 0 0]';];
    a = solveq(K,Fb,bc2);
    Ks(1:4,3) = U1(:,[1 3 4 6])'*K*a;
    bc2=[bc; LN1 U1(LN1,:)*[0 0 0 0 0 1]';];
    a = solveq(K,Fb,bc2);
    Ks(1:4,4) = U1(:,[1 3 4 6])'*K*a;
    
J1.fmap = U1(:,[1 3 4 6]);
J1.K = Ks
    
    
F = [0 2000 0 0]'
X=Ks\F
u0=[U1(:,[1 3 4 6])]*X;
LN=[LN1];
bc2=[bc; LN u0(LN)];
disp('Solving system ...');
a = solveq(K,Fb,bc2);
disp('Solved');
n=size(N,1);
ux=a(1:3:3*n);
uy=a(2:3:3*n);
uz=a(3:3:3*n);

u = [ux uy uz];

disp('Ploting displacement.');
edit classdef

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
disp('Ploting stress');
figure(2)
eldraw3(EN,N,sigma_nod)
colorbar();
title('von Mises Stress (MPa)');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');
axis equal;
disp('Analysis Done.');