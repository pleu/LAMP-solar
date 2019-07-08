classdef ElectricalFieldResults
  % ElectricalFieldResults class for Electrical Field Results
  % Input
  % Filename - Filename of results
  
  % Copyright 2011
  % Baomin Wang
  % LAMP, University Pittsburgh
  properties
    Filename;
  end
  properties (Dependent = true)
    E2Results;   % ElectricalFieldData object
    PabsResults;   % ElectricalFieldData object
  end
  methods
    function sr = ElectricalFieldResults(filename)
      if nargin == 1
        sr.Filename = filename;
      end
    end
    
    function E2results = get.E2Results(sr)
      [electricalintensity,x,z,geo] = ...
        sr.ReadMonitorResults([sr.Filename, 'E2']);
      E2results = ElectricalFieldData('E2',electricalintensity,x,z,geo);
    end
    function  Pabsresults = get.PabsResults(sr)
      [electricalintensity,x,z,geo] = ...
        sr.ReadMonitorResults([sr.Filename, 'Pabs']);
      Pabsresults = ElectricalFieldData('Pabs',electricalintensity,x,z,geo);
    end
    
  end
  
  methods(Static)
    function [electricalintensity,x,z,geo] = ReadMonitorResults(filename)
      output = load(filename);
      NoRow=size(output,1);
      NoCo=size(output,2);
      x=output(2:NoRow,2);
      z=output(1,3:NoCo);
      geo=output(1:3,1);
      electricalintensity = output(2:NoRow, 3:NoCo);
    end
    
   
  end
end