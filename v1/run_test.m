clear

path = 'H:\Users\adam\Documents\femtest\';

%% Part 1
name = 'part1';

mainfile = [path name '\' name '.ans']
pfiles = {[path name '_1\' name '_1.ans'], [path name '_2\' name '_2.ans'], [path name '_3\' name '_3.ans']}
points=[25 90 -10; -5 90 -10; 10 -10 0];
[Ks, K, U, edof, coord, LN, bc0] = compK(mainfile, pfiles, points);
F=[0 0 0 0 0 0 0 1000 0 0 0 0 0 0 0 0 0 0]'
x=solveq(Ks,F,[13 14 15 16 17 18; 0 0 0 0 0 0]')

bn = [cell2mat(LN(1)); cell2mat(LN(2))];
bc=[bc0; bn U(bn,:)*x]
Fb = zeros(size(K,1),1);
u = solveq(K,Fb,bc);
disp = dofsplit(u);
figure(1)
clf
eldisp3(edof,coord,disp,500)

A=element()
A.Ks = Ks;
A.K = K;
A.gmap=[1 2 3 4 5 6 7 8 9 10 11 12 26 26 26 26 26 26];
A.lmap=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
A.U = U;
A.edof = edof;
A.coord = coord;
A.LN = LN;

%% Part 2
name = 'part2';

mainfile = [path name '\' name '.ans']
pfiles = {[path name '_1\' name '_1.ans'], [path name '_2\' name '_2.ans']}
points=[0 -10 -10; 200 -10 -10]
[Ks, K, U, edof, coord, LN, bc0] = compK(mainfile, pfiles, points);
F=[0 0 0 0 0 0 1000 0 0 0 0 0]'
x=solveq(Ks,F,[1 0; 2 0; 3 0])
% x=Ks\F

bn = [cell2mat(LN(1)); cell2mat(LN(2))];
bc=[1 0; 2 0; 3 0; bc0; bn U(bn,:)*x]
Fb = zeros(size(K,1),1);
u = solveq(K,Fb,bc);
disp = dofsplit(u);
figure(2)
eldisp3(edof,coord,disp,500)

B=element()
B.Ks = Ks;
B.K = K;
B.gmap=[1 2 3 4 5 6 13 14 15 16 17 18];
B.lmap=[1 2 3 4 5 6 7 8 9 10 11 12];
B.U = U;
B.edof = edof;
B.coord = coord;
B.LN = LN;



%% Part 3
name = 'part1';

mainfile = [path name '\' name '.ans']
pfiles = {[path name '_1\' name '_1.ans'], [path name '_2\' name '_2.ans'], [path name '_3\' name '_3.ans']}
points=[25 90 -10; -5 90 -10; 10 -10 0];
[Ks, K, U, edof, coord, LN, bc0] = compK(mainfile, pfiles, points);
% F=[1000 0 0 0 0 0 0 0 0 0 0 0]'
% x=Ks\F
% 
% bn = [cell2mat(LN(1)); cell2mat(LN(2))];
% bc=[bc0; bn U(bn,:)*x]
% Fb = zeros(size(K,1),1);
% u = solveq(K,Fb,bc);
% disp = dofsplit(u);
% figure(3)
% eldisp3(edof,coord,disp,500)

C=element()
C.Ks = Ks;
C.K = K;
C.gmap=[20 21 22 23 24 25 19 14 15 16 17 18 27 27 27 27 27 27];
C.lmap=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
C.U = U;
C.edof = edof;
C.coord = coord;
C.LN = LN;



E=[A B C]
Kg = sparse(27,27);
for i = 1:length(E)
    Ka = E(i).Ks;
    Kg(E(i).gmap,E(i).gmap) = Kg(E(i).gmap,E(i).gmap) + Ka(E(i).lmap,E(i).lmap);
end

Fg=zeros(27,1);
Fg(13)=-1000;
Fg(19)=1000;
X=solveq(Kg,Fg,[26 0; 27 0]);
figure(4)
clf
% draw 1
offs=[0 0 0; 25 100 0; 230 0 0];
for i=1:length(E)
bn = [cell2mat(E(i).LN(1)); cell2mat(E(i).LN(2))];
bc=[bc0; bn E(i).U(bn,:)*X(E(i).gmap)]
Fb = zeros(size(E(i).K,1),1);
u = solveq(E(i).K,Fb,bc);
disp = dofsplit(u);
%clf;
eldisp3(E(i).edof,E(i).coord,disp,500,offs(i,:))
end