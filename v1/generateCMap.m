function MAT = generateCMap(u, lim)

mi = min(u)
ma = max(u)
lim=max(abs([mi ma]))
diff=ma-mi
rat=-mi/diff
zer = round(rat*100)
G = [linspace(abs(mi/lim),0,zer)'; zeros(100-zer,1)];
R = [zeros(zer,1); linspace(0, abs(ma/lim),100-zer)'];
B = [linspace(1-abs(mi/lim),1,zer)'; linspace(1,1-abs(ma/lim),100-zer)'];
MAT = [R G B];