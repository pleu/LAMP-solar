function [c, ceq] = UltimateEfficiency_constraint(x)
  Toprtop = x(1);
  Toprbot = x(2);
  TopConezSpan = x(3);
  Botrtop = x(4);            
  Botrbot = x(5);
  a = x(6);
  T = x(7);
  ntop = x(8);
  nbot = x(9);
  effectiveThickness = 100*Constants.UnitConversions.NMtoM; % nm

  c1 = [2*ntop 0 0 0 0 -1 0 0 0; 0 2*ntop 0 0 0 -1 0 0 0; 0 0 1 0 0 0 -1 0 0; 0 0 0 2*nbot 0 -1 0 0 0; 0 0 0 0 2*nbot -1 0 0 0]*([x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8) x(9)]');
  c2 = -(3*a^2*(T- effectiveThickness)/pi-(Toprtop^2+Toprtop*Toprbot+Toprbot^2)*TopConezSpan*ntop^2)/(Botrtop^2+Botrtop*Botrbot+Botrbot^2)/nbot^2;
  c = [c1;c2];
  ceq = [];