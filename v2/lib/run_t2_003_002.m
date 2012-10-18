path = 'H:\Users\adam\Documents\t2\t1-proe\';
name = 'T1-003-002';
points=[90 14 40; 188 25 -37; 30 24 18.5]
A=getComponent(name,path,points)

% 
% 
% 
% name = 't1-003-002';
% 
% mainfile = [path name '\' name '.ans']
% pfiles = {[path name '_pnt1\' name '_pnt1.ans'], [path name '_pnt2\' name '_pnt2.ans']}
% points=[188 25 -37; 30 24 18.5]
% [Ks, K, U, edof, coord, LN, bc0] = compK(mainfile, pfiles, points,K);
% F=[1000 0 0 0 0 0 0 0 0 0 0 0]'
% x=Ks\F
% 
% bn = [cell2mat(LN(1)); cell2mat(LN(2))];
% bc=[bc0; bn U(bn,:)*x]
% Fb = zeros(size(K,1),1);
% u = solveq(K,Fb,bc);
% disp = dofsplit(u);
% eldisp3(edof,coord,disp,500)
% 
% A=element()
% A.Ks = Ks;



% 
% 