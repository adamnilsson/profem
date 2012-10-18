function showResult(u, sigma_nod, N, EN, dampl)
if nargin == 1
    infile = u;
    load(infile)
    dampl=500;
end

disp('Ploting displacement...');
figure(1)
elsolid3(EN,N,u,dampl)
axis equal;
colorbar();
title('Displacement (mm)');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');

disp('Ploting stress...');
figure(2)
eldraw3(EN,N,sigma_nod, 'solid')
colorbar();
colormap(generateCMap(sigma_nod,max(abs(sigma_nod))));
title('Extended von Mises Stress (MPa)');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');
axis equal;




disp('Done')