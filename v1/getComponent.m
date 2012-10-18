function A = getComponent(name, path, points)

% path = 'H:\Users\adam\Documents\t2\t1-proe\';

%% Part 1
% name = 't1-003-002';
disp('Generating simplified stiffnesmatrix with:')
n= size(points,1);
disp([ num2str(n) 'attachpoints']);
mainfile = [path name '\' name '.ans']
pfiles={};
for i=1:n
    pfiles(i) = {[path name '_' num2str(i) '\' name '_' num2str(i) '.ans']};
end
% points=[25 90 -10; -5 90 -10; 10 -10 0];
% load('lastK');
[Ks, K, U, edof, coord, LN, bc0] = compK(mainfile, pfiles, points);

A=element()
A.Ks = Ks;
A.K = K;
A.gmap=[1 2 3 4 5 6 7 8 9 10 11 12 26 26 26 26 26 26];
A.lmap=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
A.U = U;
A.edof = edof;
A.coord = coord;
A.LN = LN;