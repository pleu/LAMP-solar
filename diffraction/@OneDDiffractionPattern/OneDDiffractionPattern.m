classdef OneDDiffractionPattern < DiffractionPattern 
  %DIFFRACTION Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Kx@double;
    NormalizedIntensity@double;
    HowCalcHaze@char;
    HazeAngle@double;
    HazeMode@double;
  end

  properties(Dependent)
    Theta@double;
  end
    
  methods
    function obj = OneDDiffractionPattern(wavelength, kx, normalizedIntensity, howCalcHaze)
      if nargin == 0
      else
        obj.Photon = Photon(wavelength);
        %obj.Theta = theta;
        obj.Kx = kx;
        obj.NormalizedIntensity = normalizedIntensity;
        angleCutoff = 2.5;
        if nargin == 3
          obj.HowCalcHaze = 'trapz';
        else
          obj.HowCalcHaze = howCalcHaze;
        end
        %obj.calc_haze_angle(angleCutoff, obj.HowCalcHaze);
        obj.HazeAngle = obj.calc_haze_angle(obj.Theta, obj.NormalizedIntensity, angleCutoff, obj.HowCalcHaze);
        obj.calc_haze_mode(obj.HowCalcHaze);
      end
    end

    function set.Kx(obj, kx)
      if size(kx, 1) ~= 1
        obj.Kx = kx';
      else
        obj.Kx = kx;
      end
    end
    
    function [theta] = get.Theta(obj)
      theta = rad2deg(asin(obj.Kx/obj.Photon.Wavenumber));
    end

    function set.Theta(obj, value)
      obj.Kx = obj.Photon.Wavenumber*sin(deg2rad(value));
    end

    
%     function [kx] = get.Kx(obj)
%       kx = obj.Photon.Wavenumber*sin(deg2rad(obj.Theta));
%     end
% 
%     function set.Kx(obj, value)
%       obj.Theta = rad2deg(asin(value./obj.K));
%     end

    function set.HowCalcHaze(obj, string)
      options = {'trapz', 'sum', 'trapzSpherical', 'sumSpherical'};
      %options = {'trapz', 'sum', 'trapzSpherical', 'sumSpherical'};
      obj.HowCalcHaze = set_value_from_list(options, string);
    end
    
  end
  
  methods(Static)
    test();
    
    hazeAngle = calc_haze_angle(theta, normalizedIntensity, angleCutoff, howCalcHaze);
  end
  
end

