function [Ks, K, U, EN, N, LN, bc] = compK(mainfile, pfiles, points, K)

disp('Parsing ansys-file ...');
[N, EN, MAT, Fb, bc,D] = ansysparser(mainfile);
disp('main file parsed.')

disp('Generating K-matrix ...');
if ~exist('K', 'var')
    K = getK3(EN,N,MAT,D);
end
save('lastK','K');
n=size(K,1);
disp('Matrix generated.');

s = length(pfiles); % antal punkter
Ks=zeros(6*s);
U=[];
LN={};
for i = 1:s
    [Ut, LNt] = parseDisp(cell2mat(pfiles(i)),n,points(i,:));
    U = [U Ut];
    LN(length(LN)+1)={LNt};
end

Ks = zeros(s*6);
for i = 1:s*6
    bc2=[bc];
    for j = 1:s
        if j==ceil(i/6)
            bc2 = [bc2; cell2mat(LN(j)) U(cell2mat(LN(j)),i)];
        else
            bc2 = [bc2; cell2mat(LN(j)) zeros(size(cell2mat(LN(j))))];
        end
    end
    
    a = solveq(K,Fb,bc2);
    Ks(:,i) = U'*K*a;
end

    