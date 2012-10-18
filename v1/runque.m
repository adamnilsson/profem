runFEM('H:\Users\adam\Documents\t2\t2-proe\t1-003-008_load1\t1-003-008_load1.ans',500,'saved_t1-003-008_load1');
load('lastK')
runFEM('H:\Users\adam\Documents\t2\t2-proe\t1-003-008_load2\t1-003-008_load2.ans',500,'saved_t1-003-008_load2',K);

runFEM('H:\Users\adam\Documents\t2\t2-proe\t1-003-008_load1_opt\t1-003-008_load1_opt.ans',500,'saved_t1-003-008_load1_opt');
load('lastK')
runFEM('H:\Users\adam\Documents\t2\t2-proe\t1-003-008_load2_opt\t1-003-008_load2_opt.ans',500,'saved_t1-003-008_load2_opt',K);

runFEM('H:\Users\adam\Documents\t2\t2-proe\t2-007-003_load1\t2-007-003_load1.ans',500,'saved_t2-007-003_load1');

runFEM('H:\Users\adam\Documents\t2\t2-proe\t2-007-003_load1_opt\t2-007-003_load1_opt.ans',500,'saved_t2-007-003_load1_opt');


showResult('saved_t1-003-008_load1')
showResult('saved_t1-003-008_load1_opt')
showResult('saved_t1-003-008_load2')
showResult('saved_t1-003-008_load2_opt')
showResult('saved_t2-007-003_load1')
showResult('saved_t2-007-003_load1_opt')