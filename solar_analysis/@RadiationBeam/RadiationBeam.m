classdef RadiationBeam < handle
  %UNTITLED3 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Latitudes; % latitudes in degrees
    Days;     % days
    IbD; % daily incident direct beam insolation (in kW-h/m^2/day); x-axis is for days, y-axis is for latitudes
    IdD; % daily incident diffuse beam insolation (in kW-h/m^2/day)
    ITD; % daily incident total beam insolation (in kW-h/m^2/day)
  end
  
  properties(Dependent = true, Hidden)
    LatitudeRad; % latitude in radians
    Delta; % declination angle in Radians
  end
  
  methods
    function rb = RadiationBeam(latitudes, days)
      rb.Latitudes = latitudes;
      rb.Days = days;
    end
    
    function delta = get.Delta(rb)
      delta = RadiationBeam.calculate_delta(rb.Days);
    end
    
    function latitudeRad = get.LatitudeRad(rb)
      latitudeRad = deg2rad(rb.Latitudes);
    end

    function [rb] = calculate_daily_insolation(rb)
      omega = linspace(0, pi, 100);
      omega = [-omega(end:-1:2) omega]';
      
      [omegaMat, latitudeMat, deltaMat] = ndgrid(omega, rb.LatitudeRad, rb.Delta); % 

      cosThetaZMat = sin(deltaMat).*sin(latitudeMat)+cos(deltaMat).*cos(latitudeMat).*cos(omegaMat);
      
      sinAlphaSMat = cosThetaZMat;
      alphaSMat = asin(sinAlphaSMat);
            
      alphaSMat(alphaSMat < 0) = 0;
      %thetaSMat(thetaSMat > pi/2) = 0;
      
      Ib = 1.353*0.7.^((1./cosThetaZMat).^0.678);
      Ib(alphaSMat <= 0) = 0;
      Id = 0.1.*Ib;
      
      
      sinAlphaSMat = cosThetaZMat;
      alphaSMat = asin(sinAlphaSMat);
      
      cosGammaSMat = (cosThetaZMat.*sin(latitude) - sin(deltaMat))./(sin(thetaZMat).*cos(latitude));
      %cosPhiSMat = (sin(deltaMat).*cos(latitude)-cos(deltaMat).*sin(latitude).*cos(omegaMat))./cos(alphaSMat);
      gammaSMat = sign(omegaMat).*acos(cosGammaSMat);
      gammaSMat(isnan(gammaSMat)) = 0;
      %phiSMat(omega >= 0) = -phiSMat(omega >= 0)+2*pi;
      
      gammaSMat(alphaSMat <= 0) = 0;
      gammaSMat = real(gammaSMat);
      
      alphaSMat(alphaSMat < 0) = 0;
      [rb.IbNormx, rb.IbNormy, rb.IbNormz] = sph2cart(gammaSMat, alphaSMat, 1);
      
      rb.IbD = reshape(12/pi*trapz(omega, Ib, 1), length(rb.Latitudes), length(rb.Days));
      rb.IdD = reshape(12/pi*trapz(omega, Id, 1), length(rb.Latitudes), length(rb.Days));

      rb.ITD = rb.IbD + rb.IdD;
    end
    
  end
  
  methods(Static)
    function delta = calculate_delta(day)
      % gives declination angle in degrees with day input
      % from Cooper, 1969
      delta = deg2rad(23.45 *sind(360/365*(284+day)));
    end
    
    test()
    
  end
  
end

