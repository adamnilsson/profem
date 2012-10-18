function Ks = extractSub(filename,K,Fb, bc, n,x,y,z)
[U, LN] = parseDisp(filename,n,0,0,1000);
I=eye(6);
Ks=zeros(6);
for i=1:6
    bc2=[bc; LN U(LN,:)*I(:,i)];
    a = solveq(K,Fb,bc2);
    Ks(:,i) = U'*K*a;
end