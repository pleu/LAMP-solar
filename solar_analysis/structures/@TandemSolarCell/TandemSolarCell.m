classdef TandemSolarCell
  %TANDEMSOLARCELL Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    SolarSpectrum;
    MaterialLayers;
  end
  
  properties(Dependent)
    BandGaps;
  end
  
  methods
    function obj = TandemSolarCell(ss, bandGaps)
      bandGaps = sort(bandGaps, 'descend');
      if isrow(bandGaps)
        bandGaps = bandGaps';
      end
      obj.SolarSpectrum = ss;
      %obj.MaterialLayers = MaterialLayer.empty(length(bandGaps), 0);
      %for i = 1:length(bandGaps)
      obj.MaterialLayers = MaterialLayer(bandGaps);
      %end
    end
    
    function [JsSun, F0t] = calc_maximum_power_point(obj)
      %voltages = obj.BandGaps - Constants.LightConstants.k_B*Constants.LightConstants.T_a;
      JsSun = zeros(length(obj.MaterialLayers), 1);
      for i =1:length(obj.MaterialLayers)
        if i == 1
          JsSun(1) = obj.SolarSpectrum.calc_max_short_circuit_current(obj.BandGaps(i));
        else
          JsSun(i) = obj.SolarSpectrum.calc_max_short_circuit_current(obj.BandGaps(i), obj.BandGaps(i-1));
        end
      end
      
      be = SolarSpectrum.create_blackbody_spectrum(Constants.LightConstants.T_a, obj.SolarSpectrum.Wavelength);
      F0t = zeros(length(obj.MaterialLayers), 1);
      for i =1:length(obj.MaterialLayers)
        F0t(i) = pi*be.calc_max_short_circuit_current(obj.BandGaps(i));
      end   
          
      %emissionSpectrum = SolarSpectrum.calculate_be;
      
    end
    
    function bandgaps = get.BandGaps(obj)
      bandgaps = [obj.MaterialLayers.BandGap];
    end
    
  end
  
  
  methods(Static)
    test();
    
    [powerDensity, powerDensityGradient] = power_density(V, JSun, F0t);
    
  end
end

