function vMs = vMstress(stress)

vMM = [1 -.5 -.5 0 0 0; -.5 1 -.5 0 0 0; -.5 -.5 1 0 0 0; 0 0 0 3 0 0; 0 0 0 0 3 0; 0 0 0 0 0 3];
vMs = zeros(size(stress,1),1);
for i=1:size(stress,1)
    es = stress(i,:);
    vMs(i) = sqrt(es*vMM*es');
end