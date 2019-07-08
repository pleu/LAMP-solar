classdef StepFunctionAbsorber < Absorber
% StepFunctionAbsorber class for solar cell
% Considers varying absoprtion coefficient
% Assumes perfectly reflecting back surface and perfectly antireflecting
% front surface
%
% See also SolarSpectrum, MaterialData, SolarCell
% 
% Copyright 2011
% Paul Leu 
  properties
    Name; % description of file
    BandGap;  % energy in eV;  > Bandgap, Absorption = 1
              % < Bandgap, Absorption = 0
    AbsorptionResults;
  end

  methods    
    function sfa = StepFunctionAbsorber(name, bandgap, energy)
%      sfa = sfa@AbsorptionStructureType();
      if nargin == 2
        sfa.Name = name;
        sfa.BandGap = bandgap;
        
        ss = SolarSpectrum.global_AM1p5;
        data = zeros(length(ss.Energy), 1);
        data(ss.Energy >= bandgap) = 1;                
        sfa.AbsorptionResults = Monitor('Absorption', Photon.convert_energy_to_frequency(ss.Energy), data);
      else
        sfa.Name = name;
        sfa.BandGap = bandgap;

        data = zeros(length(energy), 1);
        data(energy >= bandgap) = 1;
        sfa.AbsorptionResults = Monitor('Absorption', Photon.convert_energy_to_frequency(energy), data);
      end
    end
  end
  methods(Static) 
    function [scArray] = create_step_function_absorbers_array(bandGapArray, energy)
      scArray = StepFunctionAbsorber.empty(length(bandGapArray), 0);  
      for i = 1:length(bandGapArray)
        scArray(i) = StepFunctionAbsorber('', bandGapArray(i), energy);
      end
    end
  end
  
end



