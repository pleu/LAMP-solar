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
    Lambdas; % wavelengths in nm
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
    
    IbAdayAverage;
    IdAdayAverage;
    ITAdayAverage;
    
    IbmAdayAverage;
    IdmAdayAverage;
    ITmAdayAverage;
    
    IbmA;
    IdmA;
    ITmA;
    
    PhiBD;
    PhiBmD;
    
    PhiDD;
    PhiDmD;
    
    PhiTD;
    PhiTmD;
        
    PhibA;
    PhidA;
    PHiTA;
        
    PhibmA;
    PhidmA;
    PhiTmA;
    
    Omegas; % hour angle in radians
    
    ModuleType;
    SpectralFlag;
    
    %Radiation;
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
    function rb = RadiationBeam(latitudes, days, betas, gammas, moduleType, betaFractionFlag, spectralFlag, lambdas)
      rb.Latitudes = latitudes;
      rb.Days = days;
      rb.Betas = betas;
      rb.Gammas = gammas;
      if nargin == 4
        rb.ModuleType = 'fixed';
        betaFractionFlag = 0;
      else
        rb.ModuleType = moduleType;
      end
      if nargin < 5
        rb.BetaFractionFlag = 0;
      else
        rb.BetaFractionFlag = betaFractionFlag;
      end
      if nargin < 6
        rb.SpectralFlag = 0;
      else
        rb.SpectralFlag= spectralFlag;
        rb.Lambdas = lambdas;
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
      %omega = linspace(-pi, pi, 100); % little bit better accuracy
      %omega = [-omega(end:-1:2) omega]';
      rb.Omegas = omega;
      rb.calculate_daily_insolation2();
      
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
    
    function [rb] = calculate_daily_insolation2(rb)
      if ~rb.BetaFractionFlag
        if strncmpi(rb.ModuleType,'fixed', 1)
          if rb.SpectralFlag == 0
            [omegaMat, latitudeMat, deltaMat, betaMat, gammaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta, rb.BetaRad, rb.GammaRad); %
          else
            [omegaMat, latitudeMat, deltaMat, betaMat, gammaMat, lambdaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta, rb.BetaRad, rb.GammaRad, rb.Lambdas); %
          end
        elseif strncmpi(rb.ModuleType, '1axis', 5) 
          [omegaMat, latitudeMat, deltaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta); %
        end
      else
        if rb.SpectralFlag == 0
          [omegaMat, latitudeMat, deltaMat, betaMat, gammaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta, rb.Betas, rb.GammaRad); %
        else
          [omegaMat, latitudeMat, deltaMat, betaMat, gammaMat, lambdaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta, rb.Betas, rb.GammaRad, rb.Lambdas); %
        end
      end
      %      [omegaMat, latitudeMat, deltaMat, betaMat, gammaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Delta, rb.BetaRad, rb.Gammas);
      %omegaS = acos(-tan(latitudeMat).*tan(deltaMat)); % sunset angle
      %omegaMat = 
      
      cosThetaZMat = sin(deltaMat).*sin(latitudeMat)+cos(deltaMat).*cos(latitudeMat).*cos(omegaMat);
      thetaZMat = acos(cosThetaZMat);
      sinAlphaSMat = cosThetaZMat;
      alphaSMat = asin(sinAlphaSMat);
      
      
  
%       cosThetaZMat = real(cosThetaZMat);
      %omega = omega_s.*linspace(0, 1, numOmega);
      
            
      alphaSMat(alphaSMat < 0) = 0;
      thetaZMat(thetaZMat > pi/2) = pi/2;
      cosThetaZMat(alphaSMat <= 0) = 0; % is this working?
      %thetaSMat(thetaSMat > pi/2) = 0;
      
      
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
      
      if strncmpi(rb.ModuleType,'fixed', 1)
        if rb.BetaFractionFlag
          cosThetaTiltMat = cosThetaZMat.*cos(betaMat.*latitudeMat)+sin(thetaZMat).*sin(betaMat.*latitudeMat).*cos(gammaSMat - gammaMat);
        else
          cosThetaTiltMat = cos(thetaZMat).*cos(betaMat)+sin(thetaZMat).*sin(betaMat).*cos(gammaSMat - gammaMat);
        end
      elseif strncmpi(rb.ModuleType, '1axisEW', 7) % rotate along east-west direction
        cosThetaTiltMat = sqrt(1 - cos(deltaMat).^2.*sin(omegaMat).^2);
        betaMat = atan(tan(thetaZMat).*abs(cos(gammaSMat)));
      elseif strncmpi(rb.ModuleType, '1axisNS', 7)
        cosThetaTiltMat = sqrt(cos(thetaZMat).^2+cos(deltaMat).^2.*sin(omegaMat).^2); 
        gammaMat = zeros(size(gammaSMat));
        gammaMat(gammaSMat > pi/2) = pi/2;
        gammaMat(gammaSMat <= pi/2) = -pi/2;
        betaMat = atan(tan(thetaZMat).*abs(cos(gammaMat - gammaSMat)));
      end
      
      
      
        
      if rb.SpectralFlag == 0
 %     if strncmpi(rb.RadiationType, 'irradiance', 3)
        Ib = 1.353*0.7.^((1./cosThetaZMat).^0.678);
        Ib(alphaSMat <= 0) = 0;
        
        Id = 0.1.*Ib;
        
        

      else
        %wavelengthMin = min(rb.Lambdas);
        %wavelengthMax = max(rb.Lambdas);
        
        ss0 = SolarSpectrum.AM0;
        ss1p5G = SolarSpectrum.global_AM1p5();
        ss1p5D = SolarSpectrum.direct_AM1p5();
        
        ss0.interpolate_data(rb.Lambdas);
        ss1p5G.interpolate_data(rb.Lambdas);
        ss1p5D.interpolate_data(rb.Lambdas);
       
        
        FbnRatio = (ss1p5D.Irradiance./ss0.Irradiance);
        FbnRatio(FbnRatio > 1) = 1;
        
        FbnRatioVec(1,1,1,1,1,:) = FbnRatio;
        FbRatioMat = repmat(FbnRatioVec, [rb.NumOmega, rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas]);
        irradianceVec(1,1,1,1,1,:) = ss0.Irradiance;
        irradianceMat = repmat(irradianceVec, [rb.NumOmega, rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas]);

        Fbn = irradianceMat.*(FbRatioMat).^((1./cosThetaZMat/1.5).^0.678);
        
        FGRatio = ss1p5G.Irradiance./ss0.Irradiance;
        FGRatio(FGRatio > 1) = 1;        
        FGRatio(FGRatio < 0) = 0; 
        FGRatioVec(1,1,1,1,1,:) = FGRatio;
        FGRatioMat = repmat(FGRatioVec, [rb.NumOmega, rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas]);

        FG = irradianceMat.*(FGRatioMat).^((1./cosThetaZMat/1.5).^0.678);
        %photonFluxGNM = irradianceGMat./energyMat./Constants.LightConstants.Q; 
        Fd = FG - Fbn;
        
        wavelengthIndex = 6;
        WtoKW = 0.001;
        Ib = trapz(ss0.Wavelength,Fbn, wavelengthIndex)*WtoKW;
        Id = trapz(ss0.Wavelength, Fd, wavelengthIndex)*WtoKW;
        
        bb = Fbn.*lambdaMat./Constants.LightConstants.HC./Constants.LightConstants.Q;
        
%        energyMat = Photon.convert_wavelength_to_energy(lambdaMat);
%        bb2 = Fbn./energyMat./Constants.LightConstants.Q; 
        bg = FG.*lambdaMat./Constants.LightConstants.HC./Constants.LightConstants.Q;
        
        bd = bg - bb;
        %bd = Fd.*lambdaMat./Constants.LightConstants.HC./Constants.LightConstants.Q;
        
        phiB = trapz(ss0.Wavelength, bb, wavelengthIndex);
        phiD = trapz(ss0.Wavelength, bd, wavelengthIndex);
        % bn = Fbn.*ss0.Wavelength./
        
        phiBtilt = phiB.*cosThetaTiltMat(:, :, :, :, :, 1);
        phiBtilt(phiBtilt<0) = 0;
        
        phiDtilt = (1+cos(betaMat(:, :, :, :, :, 1)))./2.*phiD;
      end
      
      Ibtilt = Ib.*cosThetaTiltMat(:, :, :, :, :, 1);
      Ibtilt(Ibtilt<0) = 0;
      
      if rb.BetaFractionFlag
        Idtilt = (1+cos(betaMat(:, :, :, :, :, 1).*latitudeMat(:, :, :, :, :, 1)))./2.*Id;
      else
        Idtilt = (1+cos(betaMat(:, :, :, :, :, 1)))./2.*Id;
      end
      
      if strncmpi(rb.ModuleType,'fixed', 1)
        rb.IdD = reshape(12/pi*trapz(rb.Omegas, Id, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
        rb.IdmD = reshape(12/pi.*trapz(rb.Omegas, Idtilt, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
        
        rb.IbD = reshape(12/pi*trapz(rb.Omegas, Ib, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
        rb.IbmD = reshape(12/pi.*trapz(rb.Omegas, Ibtilt, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
        if rb.SpectralFlag
          rb.PhiBD = reshape(12/pi*3600*trapz(rb.Omegas, phiB, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
          rb.PhiBmD = reshape(12/pi*3600*trapz(rb.Omegas, phiBtilt, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
          
          rb.PhiDD = reshape(12/pi*3600*trapz(rb.Omegas, phiD, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
          rb.PhiDmD = reshape(12/pi*3600*trapz(rb.Omegas, phiDtilt, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
        end
      else
        rb.IdD = reshape(12/pi*trapz(rb.Omegas, Id, 1), rb.NumLatitudes, rb.NumDays);
        rb.IdmD = reshape(12/pi.*trapz(rb.Omegas, Idtilt, 1), rb.NumLatitudes, rb.NumDays);
        
        rb.IbD = reshape(12/pi*trapz(rb.Omegas, Ib, 1), rb.NumLatitudes, rb.NumDays);
        rb.IbmD = reshape(12/pi.*trapz(rb.Omegas, Ibtilt, 1), rb.NumLatitudes, rb.NumDays);
      end
      
      
      
      
      rb.ITD = rb.IbD + rb.IdD;
      rb.ITmD = rb.IbmD + rb.IdmD;

      % annual data
      %rb.IbA; % annual
      dayIndex = 2;
      rb.IbA = trapz(rb.Days, rb.IbD, dayIndex);
      rb.IdA = trapz(rb.Days, rb.IdD, dayIndex);
      rb.ITA = trapz(rb.Days, rb.ITD, dayIndex);

      rb.IbmA = trapz(rb.Days, rb.IbmD, dayIndex);
      rb.IdmA = trapz(rb.Days, rb.IdmD, dayIndex);
      rb.ITmA = trapz(rb.Days, rb.ITmD, dayIndex);
      if rb.SpectralFlag
        rb.PhiTD = rb.PhiBD + rb.PhiDD;
        rb.PhiTmD = rb.PhiBmD + rb.PhiDmD;
        
        rb.PhibA = trapz(rb.Days, rb.PhiBD, dayIndex);
        rb.PhidA = trapz(rb.Days, rb.PhiDD, dayIndex);
        rb.PHiTA = trapz(rb.Days, rb.PhiTD, dayIndex);
        
        rb.PhibmA = trapz(rb.Days, rb.PhiBmD, dayIndex);
        rb.PhidmA = trapz(rb.Days, rb.PhiDmD, dayIndex);
        rb.PhiTmA = trapz(rb.Days, rb.PhiTmD, dayIndex);
      end
    end
    
    
    function [rb] = calculate_daily_insolation(rb)
      if ~rb.BetaFractionFlag
        [omegaMat, latitudeMat, betaMat, gammaMat, deltaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.BetaRad, rb.GammaRad,rb.Delta); %
      else
        [omegaMat, latitudeMat, betaMat, gammaMat, deltaMat] = ndgrid(rb.Omegas, rb.LatitudeRad, rb.Betas, rb.GammaRad,rb.Delta); %
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
      
      if strncmpi(rb.ModuleType,'fixed', 1)
        
        if rb.BetaFractionFlag
          cosThetaTiltMat = cosThetaZMat.*cos(betaMat.*latitudeMat)+sin(thetaZMat).*sin(betaMat.*latitudeMat).*cos(gammaSMat - gammaMat);
        else
          cosThetaTiltMat = cos(thetaZMat).*cos(betaMat)+sin(thetaZMat).*sin(betaMat).*cos(gammaSMat - gammaMat);
        end
      elseif strncmpi(rb.ModuleType, '1axisEW', 5) % rotate along east-west direction
        cosThetaTiltMat = sqrt(1 - cos(deltaMat).^2.*sin(omegaMat).^2);
        betaMat = atan(tan(thetaZMat).*abs(cos(gammaSMat)));
      elseif strncmpi(rb.ModuleType, '1axisNS', 5)
        cosThetaTiltMat = sqrt(cos(thetaZMat).^2+cos(deltaMat).^2.*sin(omegaMat).^2);        
        betaMat = atan(tan(thetaZMat).*abs(cos(gammaMat - gammaSMat)));
      end
        
      Ibtilt = Ib.*cosThetaTiltMat;
      Ibtilt(Ibtilt<0) = 0;
      Id = 0.1.*Ib;

      if rb.BetaFractionFlag
        Idtilt = (1+cos(betaMat.*latitudeMat))./2.*Id;
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
            
      rb.IbAdayAverage = rb.IbA/(rb.Days(end)-rb.Days(1));
      rb.IdAdayAverage = rb.IdA/(rb.Days(end)-rb.Days(1));
      rb.ITAdayAverage = rb.ITA/(rb.Days(end)-rb.Days(1));
      
      rb.IbmAdayAverage = rb.IbmA/(rb.Days(end)-rb.Days(1));
      rb.IdmAdayAverage = rb.IdmA/(rb.Days(end)-rb.Days(1));
      rb.ITmAdayAverage = rb.ITmA/(rb.Days(end)-rb.Days(1));
    end
    
    
    function [tiltMisalignmentRelative, avgOverAllLatitudes] = contour_tilt_misalignment(rb, misalignmentMagnitude)
     
      %tiltMisalignment = -misalignmentMagnitude:2:misalignmentMagnitude;
      numTilts = 100;
      ItMAinterp = zeros(rb.NumLatitudes, numTilts);
      tiltMisalignmentRelative = linspace(-misalignmentMagnitude, misalignmentMagnitude);
      for ind = 1:rb.NumLatitudes
        [maxVal, maxInd] = max(rb.ITmA(ind, :));
        tiltMisalignment = tiltMisalignmentRelative + rb.Betas(maxInd);
        ItMAinterp(ind, :) = interp1(rb.Betas, rb.ITmA(ind, :), tiltMisalignment)./maxVal;
      end
      %[betasMat, latitudesPlotMat] = meshgrid(rb.Betas, rb.Latitudes);      
      
      %[tiltMisalignmentMat, latitudesMisalignmentMat] = meshgrid(tiltMisalignment, rb.Latitudes);
      
      %ItMAinterp =  interp2(betasMat, latitudesPlotMat, rb.ITmA, tiltMisalignmentMat, latitudesMisalignmentMat);
      [tiltMisalignmentMat,latitudesMat] = meshgrid(tiltMisalignmentRelative,rb.Latitudes);
      contourf(latitudesMat, tiltMisalignmentMat, ItMAinterp);
      
      avgOverAllLatitudes = mean(ItMAinterp, 1);
      xlabel('Latitudes (Deg)');
      ylabel('Normalized Annual Insolation');
      
      n = get(gcf,'Number')
      
      figure(n+1);
      clf;
      plot(tiltMisalignmentRelative, avgOverAllLatitudes, '-');
      xlabel('Tilt Misalignment (Degrees)');
      ylabel('Normalized Annual Insolation');
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
      obj = RadiationBeam(latitudes, days, betaFraction, gammas, 'fixed', 1);
    end
    
    test()

    test2()
    
    test3()
    
    test4()
    
    test5()
    
    test6()
    
    test7()

    contour_ITmD()

    contour_ITmA()
    
    test_script()
    
  end
  
end

