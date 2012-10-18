% Transform to a cordinate system where the volume is a unit thetraedor.
% Integrate in this area and multiply with jacobian and transform back to
% initial cordinates.

C=[[1 -1 -1; 0 0 0; 0 1 0; 0 0 0;0 0 1; 0 0 0]'; [0 0 0; 1 -1 -1; 0 0 0; 0 1 0; 0 0 0;0 0 1]']

Is = 1./[2 6 6; 6 12 24; 6 24 12]

I = [Is zeros(3); zeros(3) Is]

D=det([2 0; 2 2])
M = C'*I*C*D


inv([1 2 2;1 4 2;1 4 4])
Z = zeros(2,4)
% C3=[[1 -1 -1 -1; 0 0 0 0; 0 1 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0; 0 0 0 1; 0 0 0 0]'; [0 0 0 0; 1 -1 -1 -1; 0 0 0 0; 0 1 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0; 0 0 0 1]']
C3_sub = [1 -1 -1 -1; 0 1 0 0; 0 0 1 0; 0 0 0 1]';
C3 = zeros(12);
C3(1:4,[1 4 7 10]) = C3_sub;
C3(5:8,[1 4 7 10]+1) = C3_sub;
C3(9:12,[1 4 7 10]+2) = C3_sub;


Is3 = 1./[6 24 24 24; 24 60 120 120; 24 120 60 120; 24 120 120 60]
I3 = [Is3 zeros(4,8); zeros(4) Is3 zeros(4); zeros(4,8) Is3]

PMat = C3'*I3*C3
save('PMat','PMat')