function UE = UltimateEfficiency_fitness(x)
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

  %we get the rtop, rbot, a, T value from the generation. 
  %save('InputVariables', 'rtop', 'rbot', 'a', 'T');

  BotConezSpan = (3*a^2*(T- effectiveThickness)/pi-(Toprtop^2+Toprtop*Toprbot+Toprbot^2)*TopConezSpan*ntop^2)/(Botrtop^2+Botrtop*Botrbot+Botrbot^2)/nbot^2;  % calculate H using the calculateH function
%   H = ceil(H/Constants.UnitConversions.NMtoM)*Constants.UnitConversions.NMtoM; % round H to the nearest 1 nm.
 
  if  BotConezSpan + TopConezSpan > T || mod(ntop^2, ntop) || mod(nbot^2, nbot) 
      UE = 0; % if the length of hole is bigger than T, put the UE as 0, biggest value
  else
      runFDTD(effectiveThickness, T, a, TopConezSpan, Toprtop, Toprbot, ntop, Botrtop, Botrbot, nbot);
      materialName = 'Si';
      load('InputVariables');      % load the InputVariables, so we can use the filename
      sr = FDTDSimulationResults(filename);
      ma = MaterialType.create(materialName);
      SS = SolarSpectrum.global_AM1p5();
      sc = SolarCell(SS, sr, ma);
      UE = sc.UltimateEfficiency;
      UE = -UE;   
  end