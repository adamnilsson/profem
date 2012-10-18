filename = 'H:\Users\adam\Documents\t2\t1-proe\t2-006-010\t2-006-010.ans';
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

n=size(K,1);
[U1, LN1] = parseDisp('H:\Users\adam\Documents\t2\t1-proe\Bearing\Bearing.ans',n,13,10,0);
[U2, LN2] = parseDisp('H:\Users\adam\Documents\t2\t1-proe\screwtrans1\screwtrans1.ans',n,0,0,0);
[U3, LN3] = parseDisp('H:\Users\adam\Documents\t2\t1-proe\screwtrans2\screwtrans2.ans',n,0,0,0);


    bc2=[bc; LN1 U1(LN1,:)*[1 0 0 0 0 0]'; LN2 zeros(size(LN2)); LN3 zeros(size(LN3))];
    a = solveq(K,Fb,bc2);
    Ks(1:4,1) = U1(:,[1 2 3 6])'*K*a;
    bc2=[bc; LN1 U1(LN1,:)*[0 1 0 0 0 0]'; LN2 zeros(size(LN2)); LN3 zeros(size(LN3))];
    a = solveq(K,Fb,bc2);
    Ks(1:4,2) = U1(:,[1 2 3 6])'*K*a;
    bc2=[bc; LN1 U1(LN1,:)*[0 0 1 0 0 0]'; LN2 zeros(size(LN2)); LN3 zeros(size(LN3))];
    a = solveq(K,Fb,bc2);
    Ks(1:4,3) = U1(:,[1 2 3 6])'*K*a;
    bc2=[bc; LN1 U1(LN1,:)*[0 0 0 0 0 1]'; LN2 zeros(size(LN2)); LN3 zeros(size(LN3))];
    a = solveq(K,Fb,bc2);
    Ks(1:4,4) = U1(:,[1 2 3 6])'*K*a;
    
    
    bc2=[bc; LN2 U2(LN2,:)*[0 1 0 0 0 0]'; LN1 zeros(size(LN1)); LN3 zeros(size(LN3))];
    a = solveq(K,Fb,bc2);
    Ks(5,5) = U2(:,2)'*K*a;
    
    bc2=[bc; LN3 U3(LN3,:)*[0 1 0 0 0 0]'; LN1 zeros(size(LN1)); LN2 zeros(size(LN2))];
    a = solveq(K,Fb,bc2);
    Ks(6,6) = U3(:,2)'*K*a;

F = [0 -1000 -1000 10000 1000 0]'
X=Ks\F
u0=[U1(:,[1 2 3 6]) U2(:,2) U3(:,2)]*X;
LN=[LN1; LN2; LN3];
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
figure(1)
eldisp3(EN,N,u,500)
axis equal;
colorbar();
title('Displacement (mm)');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');

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