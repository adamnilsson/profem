% function [u, sigma_nod, K, N, EN] = runFEM(filename, dampl, outname, K)
function [u, sigma_nod, K, N, EN] = runFEM(filename, dampl, outname, K)
disp(['Starting analysis: ' filename]);
disp('Parsing ansys-file ...');
[N, EN, MAT, Fb, bc,D, rho] = ansysparser(filename);


if ~exist('K','var')
    disp('Generating K-matrix ...');
    [K,M] = getK3(EN,N,MAT,D, rho);
    save('lastK','K');
    disp('Generating K-matrix Done');
else
    disp('Using old K-matrix');
end

n=size(N,1);
fc = 1:n*3; % Free conditions
fc(bc(:,1)) = [];
A = M(fc,fc)\K(fc,fc);

[S, L] = eigs(A,7,'SM');
% [S, L] = eigs(K(fc,fc)/rho,7,'SM');
L = diag(L);
a = zeros(3*n,1);

for i = 1:7
a(fc) = S(:,i);
a(bc(:,1)) = bc(:,2);

ux=a(1:3:3*n);
uy=a(2:3:3*n);
uz=a(3:3:3*n);
u = [ux uy uz];

disp('Ploting mode...');
figure(i)
elsolid3(EN,N,u)
axis equal;
colorbar();
title('Eigenmode');
xlabel('x');
ylabel('y');
zlabel('z');
title(['Frequency = ' num2str(sqrt(L(i)))])
end

disp('Analysis Done.');