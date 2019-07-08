%function [] = test()
%TEST 
clear;
m = MaterialDatabase('Si');

obj = MaterialDatabase.getNamed(m, 'Si');
obj2 = MaterialDatabase.getNamed(m, 'Si');
obj.BandGap = 2;
assert(obj2.BandGap==2);

display('test passed')
%end

