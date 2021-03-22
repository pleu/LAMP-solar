classdef RadiationBeam < handle
  %UNTITLED3 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Latitudes; % latitudes in degrees
    Days;     % days
    Betas;    % slopes in degrees
    BetaFractionFlag; % if set to 1, then Betas is betaFraction;
    %BetaFraction; 
    Gammas;   % surface azimuth angles in degrees  
    
    %
    %Ibn;  % beam insolation 
    IbD; % daily incident direct beam insolation (in kW-h/m^2/day); x-axis is for days, y-axis is for latitudes
    IdD; % daily incident diffuse beam insolation (in kW-h/m^2/day)
    ITD; % daily incident total beam insolation (in kW-h/m^2/day)
    
    IbmD; % daily module incident direct beam insolation (in kW-h/m^2/day); dim-1 is latitude, dim-2 is days, 3. beta, 4. gamma 
    IdmD; % daily module incident diffuse beam insolation (in kW-h/m^2/day)
    ITmD; % daily module incident total beam insolation (in kW-h/m^2/day)
    
    IbA; % annual
    IdA; 
    ITA;

    IbmA;
    IdmA;
    ITmA;
    
    Omegas; % hour angle in radians
    %Variables;
  end
  
%   properties(Hidden)
%     IbNormx; % size is numOmega x numLatitudes x numDays
%     IbNormy; 
%     IbNormz;
%     
%     NormX; % module normal, size is numBeta x numGamma
%     NormY; % module normal
%     NormZ; % module normal
%   end
  
  properties(Dependent, Hidden)
    NumOmega;
    NumLatitudes;
    NumDays;
    NumBetas;
    NumGammas;
  end
  
  properties(Dependent = true, Hidden)
    LatitudeRad; % latitude in radians
    Delta; % declination angle in Radians
    BetaRad; % beta in radians
    GammaRad; % gamma in radians
  end
  
  methods
    function rb = RadiationBeam(latitudes, days, betas, gammas, betaFractionFlag)
      rb.Latitudes = latitudes;
      rb.Days = days;
      rb.Betas = betas;
      rb.Gammas = gammas;
      if nargin == 4
        rb.BetaFractionFlag = 0;
      else
        rb.BetaFractionFlag = betaFractionFlag;
      end
%         
%       elseif betaFractionFlag ==1
%         rb.Latitudes = latitudes;
%         rb.Days = days;
%         rb.Betas = [];
%         rb.Gammas = gammas;
%         rb.BetaFraction = betas;
%       end
        
      % this is strange; maybe needs to be moved out
      omega = linspace(-3*pi/4, 3*pi/4, 100); % little bit better accuracy
      %omega = [-omega(end:-1:2) omega]';
      rb.Omegas = omega;

      rb.calculate_daily_insolation();
    end

    function numOmega = get.NumOmega(rb)
      numOmega = length(rb.Omegas);
    end
    
    function numLatitudes = get.NumLatitudes(rb)
      numLatitudes = length(rb.Latitudes);
    end
    
    function numDays = get.NumDays(rb)
      numDays = length(rb.Days);
    end
    
    function numBetas = get.NumBetas(rb)
      if ~isempty(rb.Betas)
        numBetas = length(rb.Betas);
      else
        numBetas = length(rb.BetaFraction);
      end
    end
    
    function numBetas = get.NumGammas(rb)
      numBetas = length(rb.Gammas);
    end

    
    function delta = get.Delta(rb)
      delta = RadiationBeam.calculate_delta(rb.Days);
    end
    
    function betaRad = get.BetaRad(rb)
      betaRad = deg2rad(rb.Betas);
    end
    
    function gammaRad = get.GammaRad(rb)
      gammaRad = deg2rad(rb.Gammas);
    end

    function latitudeRad = get.LatitudeRad(rb)
      latitudeRad = deg2rad(rb.Latitudes);
    end

    function [rb] = calculate_daily_insolation(rb)
      if ~rb.BetaFractionFlag
        [omegaMat, latitudeMat, betaMat, gammaMat, deltaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.BetaRad, rb.GammaRad,rb.Delta); %
      else
        [omegaMat, latitudeMat, betaFractionMat, gammaMat, deltaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Betas, rb.GammaRad,rb.Delta); %
      end
      %      [omegaMat, latitudeMat, deltaMat, betaMat, gammaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta, rb.BetaRad, rb.Gammas);
      %omegaS = acos(-tan(latitudeMat).*tan(deltaMat)); % sunset angle
      %omegaMat = 
      
      cosThetaZMat = sin(deltaMat).*sin(latitudeMat)+cos(deltaMat).*cos(latitudeMat).*cos(omegaMat);
      thetaZMat = acos(cosThetaZMat);
      sinAlphaSMat = cosThetaZMat;
      alphaSMat = asin(sinAlphaSMat);
      
      
      %omega = omega_s.*linspace(0, 1, numOmega);
      
            
      alphaSMat(alphaSMat < 0) = 0;
      thetaZMat(thetaZMat > pi/2) = pi/2;
      %thetaSMat(thetaSMat > pi/2) = 0;
      
      Ib = 1.353*0.7.^((1./cosThetaZMat).^0.678); 
      Ib(alphaSMat <= 0) = 0;
      %Id = 0.1.*Ib;
      %rb.Ibn = Ib;
      
      cosGammaSMat = (cosThetaZMat.*sin(latitudeMat) - sin(deltaMat))./(sin(thetaZMat).*cos(latitudeMat));
      %cosPhiSMat = (sin(deltaMat).*cos(latitude)-cos(deltaMat).*sin(latitude).*cos(omegaMat))./cos(alphaSMat);
      gammaSMat = sign(omegaMat).*acos(cosGammaSMat);
      gammaSMat(isnan(gammaSMat)) = 0;
      %phiSMat(omega >= 0) = -phiSMat(omega >= 0)+2*pi;
      
      gammaSMat(alphaSMat <= 0) = 0;
      gammaSMat = real(gammaSMat);
      
      
      
%       [IbNormX, IbNormY, IbNormZ] = sph2cart(gammaSMat, alphaSMat, 1);
%       
%       if rb.BetaFractionFlag
%         [moduleNormX, moduleNormY, moduleNormZ] = sph2cart(gammaMat, pi/2-betaFractionMat.*latitudeMat, 1);
%       else
%         [moduleNormX, moduleNormY, moduleNormZ] = sph2cart(gammaMat, pi/2-betaMat, 1);
%       end
      
%      cosThetaTiltMat = (IbNormX.*moduleNormX+IbNormY.*moduleNormY+IbNormZ.*moduleNormZ);
      if rb.BetaFractionFlag
        cosThetaTiltMat = cosThetaZMat.*cos(betaFractionMat.*latitudeMat)+sin(thetaZMat).*sin(betaMat).*cos(gammaSMat - gammaMat);
      else
        cosThetaTiltMat = cos(thetaZMat).*cos(betaMat)+sin(thetaZMat).*sin(betaMat).*cos(gammaSMat - gammaMat);
      end
      
      Ibtilt = Ib.*cosThetaTiltMat;
      Ibtilt(Ibtilt<0) = 0;
      Id = 0.1.*Ib;

      if rb.BetaFractionFlag
        Idtilt = (1+cos(betaFractionMat.*latitudeMat))./2.*Id;
      else
        Idtilt = (1+cos(betaMat))./2.*Id;
      end

      rb.IdD = reshape(12/pi*trapz(rb.Omegas, Id, 1), rb.NumLatitudes, rb.NumBetas, rb.NumGammas,rb.NumDays);
      rb.IdmD = reshape(12/pi.*trapz(rb.Omegas, Idtilt, 1), rb.NumLatitudes, rb.NumBetas, rb.NumGammas,rb.NumDays);

      rb.IbD = reshape(12/pi*trapz(rb.Omegas, Ib, 1), rb.NumLatitudes, rb.NumBetas, rb.NumGammas,rb.NumDays);
      rb.IbmD = reshape(12/pi.*trapz(rb.Omegas, Ibtilt, 1), rb.NumLatitudes, rb.NumBetas, rb.NumGammas,rb.NumDays);

      rb.ITD = rb.IbD + rb.IdD;
      rb.ITmD = rb.IbmD + rb.IdmD;

      % annual data
      %rb.IbA; % annual
      dayIndex = 4;
      rb.IbA = trapz(rb.Days, rb.IbD, dayIndex);
      rb.IdA = trapz(rb.Days, rb.IdD, dayIndex);
      rb.ITA = trapz(rb.Days, rb.ITD, dayIndex);

      rb.IbmA = trapz(rb.Days, rb.IbmD, dayIndex);
      rb.IdmA = trapz(rb.Days, rb.IdmD, dayIndex);
      rb.ITmA = trapz(rb.Days, rb.ITmD, dayIndex);
    end
    
  end
  
  methods(Static,Hidden)
    function check_vars_plot(y, varXIndex, lineIndex)
      nDim = length(size(y));
      varsNotPlot = setdiff(1:nDim, [varXIndex lineIndex]);
      for ind = 1:length(varsNotPlot)
        if size(y, varsNotPlot(ind)) ~= 1
          error('all other variables should be of size 1');
        end
      end
    end
  end


  methods(Static)
    function delta = calculate_delta(day)
      % gives declination angle in degrees with day input
      % from Cooper, 1969
      delta = deg2rad(23.45 *sind(360/365*(284+day)));
    end

    function [obj] = create_with_betaFraction(latitudes, days, betaFraction, gammas)
      obj = RadiationBeam(latitudes, days, betaFraction, gammas, 1);
    end
    
    test()

    test2()
    
    test3()
    
    test4()
    
    test5()
    
    test6()

    contour_ITmD()

    contour_ITmA()
    
    test_script()
    
  end
  
end

