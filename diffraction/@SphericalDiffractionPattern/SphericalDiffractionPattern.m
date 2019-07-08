classdef SphericalDiffractionPattern
  %CYLINDRICALDIFFRACTIONPATTERN Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Wavelength@double;
    Theta@double;
    NormalizedIntensity@double;
    HazeAngle@double;
    HazeMode@double;
  end
  
  methods
    function obj = SphericalDiffractionPattern(wavelength, theta, normalizedIntensity)
      obj.Wavelength = wavelength;
      obj.Theta = theta;
      obj.NormalizedIntensity = normalizedIntensity;
      obj.calc_haze_angle();
      obj.calc_haze_mode();
    end
  end
  
end

