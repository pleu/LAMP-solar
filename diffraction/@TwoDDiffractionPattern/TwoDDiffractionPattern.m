classdef TwoDDiffractionPattern < DiffractionPattern
  %DIFFRACTION Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Kx;
    Ky;
    NormalizedIntensity@double;
    HowCalcHaze@char;
    HazeAngle@double;
    HazeMode@double;
    NumModes@double;
  end
%   
  
  properties(Hidden)
    Theta@double;  % spherical coordinates in radians; this is azimuth
    Phi@double;    % spherical coordinates in radians; this is zenith
    KxNormalized;
    KyNormalized;
  end
  
  methods
    function obj = TwoDDiffractionPattern(wavelength, kx, ky, normalizedIntensity, howCalcHaze)
      if nargin ~= 0
        obj.Photon = Photon(wavelength);
        obj.NormalizedIntensity = normalizedIntensity;
        angleCutoff = deg2rad(2.5);
        obj.Kx = kx;
        obj.Ky = ky;
        
        [theta, r] = cart2pol(kx, ky);
        %theta = rad2deg(theta);
        theta(theta< 0) = theta(theta < 0) + 2*pi;
        obj.Theta = theta;
        obj.Phi = real(asin(r./obj.Photon.Wavenumber));
        [obj.KxNormalized,obj.KyNormalized] = pol2cart(obj.Theta,obj.Phi);
        
        if nargin == 3
          obj.HowCalcHaze = 'trapz';
        else
          obj.HowCalcHaze = howCalcHaze;
        end
        obj.calc_haze_angle(angleCutoff, obj.HowCalcHaze);
        obj.calc_haze_mode(obj.HowCalcHaze);
      end
    end
    
%     function set.Kx(obj, kx)
%       if size(kx, 1) ~= 1
%         obj.Kx = kx';
%       else
%         obj.Kx = kx;
%       end
%     end
%     
%     function set.Ky(obj, ky)
%       if size(ky, 1) ~= 1
%         obj.Ky = ky';
%       else
%         obj.Ky = ky;
%       end
%     end

%     function [kxNormalized] = get.KxNormalized(obj)
%       %degree = pi/2;
%       kxNormalized = asin(obj.Kx./obj.Photon.Wavenumber);
%     end
% 
%     function [kyNormalized] = get.KyNormalized(obj)
%       %degree = pi/2;
%       kyNormalized = asin(obj.Ky./obj.Photon.Wavenumber);
%     end




%     function [theta] = get.Theta(obj)
%       %[kYg, kXg] = meshgrid(obj.Kx, obj.Ky);
%       %theta = atan(kYg./kXg);
%       theta = atan(obj.Ky./obj.Kx);
%     end
% 
%     function [phi] = get.Phi(obj)
%       phi = acos(1-(obj.Kx./obj.Photon.Wavenumber).^2-(obj.Kx./obj.Photon.Wavenumber).^2);
%     end
    
%     function [thetaX] = get.ThetaX(obj)
%       thetaX = rad2deg(asin(obj.Kx/obj.Photon.Wavenumber));
%     end
%     
%     function set.ThetaX(obj, value)
%       obj.Kx = obj.Photon.Wavenumber*sin(deg2rad(value));
%     end
% 
%     function [thetaX] = get.ThetaY(obj)
%       thetaX = rad2deg(asin(obj.Ky/obj.Photon.Wavenumber));
%     end
%     
%     function set.ThetaY(obj, value)
%       obj.Ky = obj.Photon.Wavenumber*sin(deg2rad(value));
%     end
        
    function set.HowCalcHaze(obj, string)
      options = {'trapz', 'sum', 'trapzSpherical', 'sumSpherical'};
      %options = {'trapz', 'sum', 'trapzSpherical', 'sumSpherical'};
      obj.HowCalcHaze = set_value_from_list(options, string);
    end
    
  end
  
  methods(Static)
    test();
  end
  
end