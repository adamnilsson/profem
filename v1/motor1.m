path = 'H:\Users\adam\Documents\t2\t1-proe\';
name = 'T1-003-002';
points=[90 14 40; 188 25 -37; 30 24 18.5]
A=getComponent(name,path,points)


path = 'H:\Users\adam\Documents\t2\t1-proe\';
name = 'T1-003-010';
points=[0 0 0; 0 -3.5 -93]
B=getComponent(name,path,points)

path = 'H:\Users\adam\Documents\t2\t1-proe\';
name = 'T2-006-010';
points=[-8 0 0; -11 0 0]
C=getComponent(name,path,points)

path = 'H:\Users\adam\Documents\t2\t1-proe\';
name = 'T2-006-006';
points=[0 0 0; 240 0 0]
D=getComponent(name,path,points)

A.gmap = [1:18]
A.lmap = [1:18]

B.gmap = [13:18 25 26 27 28 29 30]
B.lmap = [1:12]

C.gmap = [7 8 9 10 32 12 19 20 21 22 23 24]
C.lmap = [1:12]

D.gmap = [19 20 21 22 23 24 31 26 27 28 33 30]
D.lmap = [1:12]

E=[A B C D]
Kg = sparse(33,33);
for i = 1:length(E)
    Ka = E(i).Ks;
    Kg(E(i).gmap,E(i).gmap) = Kg(E(i).gmap,E(i).gmap) + Ka(E(i).lmap,E(i).lmap);
end

bc=[1:6; zeros(1,6)]';
F=zeros(33,1);
F(25)=1000;
F(31)=-1000;

X=solveq(Kg,F,bc)
1/(X(25)-X(31))

for i=1:4
n=length(E(i).LN)
bn = [];
for j = 1:n
    bn = [bn; cell2mat(E(i).LN(j))];
end
bc=[bn E(i).U(bn,:)*X(E(i).gmap)];
Fb = zeros(size(E(i).K,1),1);
u = solveq(E(i).K,Fb,bc);
disp = dofsplit(u);
%clf;
figure(i)
eldisp3(E(i).edof,E(i).coord,disp)
end

i=1
bc=[1:6; 0*[1:6]]';
F=zeros(18,1);
F(7)=-1000;
X=solveq(A.Ks,F,bc);
n=length(E(i).LN)
bn = [];
for j = 1:n
    bn = [bn; cell2mat(E(i).LN(j))];
end
bc=[bn E(i).U(bn,:)*X];
Fb = zeros(size(E(i).K,1),1);
u = solveq(E(i).K,Fb,bc);
disp = dofsplit(u);
%clf;
figure(i)
eldisp3(E(i).edof,E(i).coord,disp)

save('motor1_element','A','B','C','D')