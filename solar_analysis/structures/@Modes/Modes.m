classdef Modes
  %MODES Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Name;
    Resonances;
    DependentVariable;
  end
  
  properties(Dependent)
    Wavelength;
  end
  
  
  methods
    function mo = Modes(name, resonances, dependentVariable)
      if nargin ~= 0
        mo.Name = name;
        mo.Resonances = Photon(resonances);
        mo.DependentVariable = dependentVariable;
      end
    end
    
    function wavelength = get.Wavelength(obj)
      [wavelength] = obj.Resonances.Wavelength;
    end
    
  end
  
  methods(Static)
    test();
    test2();
    test3();
  end
  
end

