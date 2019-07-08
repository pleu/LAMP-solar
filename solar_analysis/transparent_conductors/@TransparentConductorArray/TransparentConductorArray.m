classdef TransparentConductorArray < SimulationArray
%TRANSPARENTCONDUCTORARRAY 
% 
% Copyright 2012
% Paul Leu
% LAMP, Pittsburgh

  properties
    TransparentConductors;
    Transmission;
    Reflection;
    SheetResistance;
    SigmaDCSigmaOP;
    SigmaAlpha;
  end
    
  methods(Access = protected)
    function tca = TransparentConductorArray(transparentConductors,...
      variableArray)
      tca.TransparentConductors = transparentConductors;
      tca.VariableArray = variableArray;
    end
  end
  
  methods    
    function sigmaAlpha = get.SigmaAlpha(tca)
      sigmaAlpha = [tca.TransparentConductors.SigmaAlpha];
    end
    
    function sigmaDCSigmaOP = get.SigmaDCSigmaOP(tca)
      sigmaDCSigmaOP = [tca.TransparentConductors.SigmaDCSigmaOP];
    end

    function transmission = get.Transmission(tca)
      transmission = [tca.TransparentConductors.TransmissionIntegrated];
    end
    
    function reflection = get.Reflection(tca)
      reflection = [tca.TransparentConductors.ReflectionIntegrated];
    end
    
    function sheetResistance = get.SheetResistance(tca)
      sheetResistance = [tca.TransparentConductors.SheetResistance];
    end 
    
  end
  
  methods(Static)
    

    [tcArray] = create_circle_array(solarSpectrum,...
      variableArray, material, independentVariableType)

    [tcArray] = create_rectangle_array(solarSpectrum,...
      variableArray, material, independentVariableType)

    [tcArray] = create_thin_film_array(solarSpectrum,...
      variableArray, material, independentVariableType)

    [tcArray] = create_nano_mesh_array(solarSpectrum,...
      variableArray, material, independentVariableType)   
  
    [tcArray] = create_core_shell_array(solarSpectrum,...
      variableArray, materialCore, materialShell, ...
      independentVariableType) 
    
    [] = test();
  end

end

