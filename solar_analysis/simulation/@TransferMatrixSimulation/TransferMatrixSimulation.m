classdef TransferMatrixSimulation < handle
%TRANSFERMATRIXSIMULATION 
% Simulates 1-d layer of materials using the transfer matrix method
%
% See also SolarSpectrum, MaterialData
% 
% Copyright 2012
% Paul Leu 
  
  properties
    SolarSpectrum;   % this can be any spectrum and does not have to 
                     % be the solar spectrum
    ThinFilmLayers;       % this is an array of thin film layers
    Theta;
    
  end
  
  properties(SetAccess='private')
    SimulationResultsTE;
    SimulationResultsTM;
    TsIntegrated;
    TpIntegrated;
    RsIntegrated;
    RpIntegrated;
    AsIntegrated;
    ApIntegrated;
    SheetResistance;       % Sheet resistance in Ohm/Square
                            % for 1D grating we use R_s = rho*a/A;
  end
  
  properties(Hidden = true)
    N;         % complex N
    KLayers;   % Units of 1/m
    ThetaLayers;
    NumLayers;
    NumWavelengths;
    CoeffS;
    CoeffP;
  end

  properties (Dependent = true)
    Thicknesses;
  end
  
  methods
    function tm = TransferMatrixSimulation(solarSpectrum, ...
        structure, theta)
      tm.SolarSpectrum = solarSpectrum;
      tm.ThinFilmLayers = structure;  
      if nargin == 2
        tm.Theta = 0;
      else
        tm.Theta = theta;      % normal incidence for now
      end
      %tm = tm.structure_preprocessing();
      tm.NumLayers = length(tm.ThinFilmLayers);
      % tm.Thicknesses = tm.ThinFilmLayers.;
      tm.NumWavelengths = tm.SolarSpectrum.NumWavelength;
      tm.N = tm.ThinFilmLayers.get_refractive_index(tm.SolarSpectrum.Wavelength);
    end
    
    function tm = simulate(tm)
      tm.SimulationResultsTE = SimulationResults(tm.SolarSpectrum.Wavelength);
      tm.SimulationResultsTM = SimulationResults(tm.SolarSpectrum.Wavelength);
      
      % tm = tm.structure_preprocessing();
      tm = tm.calculate_theta_and_k_vector();
      [tm.CoeffS, tm.CoeffP] = tm.simulate_wavelengths;
      tm = tm.calculate_transmission;
      tm = tm.calculate_reflection;
      %tm = tm.calculate_absorption_from_R_and_T;
      tm = tm.calculate_absorption;
    %end
%      tm = tm.calculate_transmission_and_reflectionTE();
%tm.SheetResistance = tm.calc_sheet_resistance();
      %tm = tm.calculate_transmission_and_reflectionTM();
%      [lightInfo] = CalculateThetaAndKVector(structureInfo, lightInfo);
    end

    
    function [tm] = calculate_absorption_from_R_and_T(tm)
      [tm.SimulationResultsTE] = tm.SimulationResultsTE.calc_absorption_results;
      [tm.SimulationResultsTM] = tm.SimulationResultsTM.calc_absorption_results;
      [wavelength, dataTE] = tm.SimulationResultsTE.get_versus_wavelength('Absorption');
      [wavelength, dataTM] = tm.SimulationResultsTM.get_versus_wavelength('Absorption');
      tm.AsIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy,dataTE);
      tm.ApIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy,dataTM);
    end
    
    function [tm] = calculate_absorption(tm)
      [absorptionResultsTE] = calculate_absorption_from_coeffs(tm, tm.CoeffS);
      tm.SimulationResultsTE.set_versus_wavelength('Absorption', tm.SolarSpectrum.Wavelength, absorptionResultsTE);
      tm.AsIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy, absorptionResultsTE);

      [absorptionResultsTM] = calculate_absorption_from_coeffs(tm, tm.CoeffP);
      tm.SimulationResultsTM.set_versus_wavelength('Absorption', tm.SolarSpectrum.Wavelength, absorptionResultsTM);
      tm.ApIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy, absorptionResultsTM);
    end
      
    function [absorptionResult] = calculate_absorption_from_coeffs(tm, coeff)
      middleLayerIndex = 2:tm.NumLayers-1;
      E0f = squeeze(coeff(:, 1, middleLayerIndex)).';
      E0b = squeeze(coeff(:, 2, middleLayerIndex)).';
      
      kZ(1:length(middleLayerIndex), 1:tm.NumWavelengths) = tm.KLayers(:, middleLayerIndex).';
      
      kZR = real(kZ);
      kZI = imag(kZ);
      
      
      dm = tm.Thicknesses(middleLayerIndex);
      dm = dm.'*ones(1, size(kZ, 2));   
      
      kZ0 = tm.KLayers(:, 1)'; % incident wave vector
      %kZ0 = ones(size(structureInfo.tVector(:, analyzeResultsInfo.tIndex), 1),1)*kZ0;
      A = coeff(:, 1, 1)';
      % EZ0 = simResults.coeffS(wavelengthIndex, tVectorIndex, 1, tIndex)'; % incident wave vector
      
      % absorption = -(kZR.*((E0f.*conj(E0f)).*exp(-2.*abs(kZI).*dm)-(E0b.*conj(E0b)).*exp(2.*abs(kZI).*dm))-2.*kZI.*imag(E0f.*conj(E0b).*exp(-2*i*kZR.*dm)) - ...
      %     (kZR.*((E0f.*conj(E0f))-(E0b.*conj(E0b)))-2.*kZI.*imag(E0f.*conj(E0b))))
      
      
      absorption = -(kZR.*((E0f.*conj(E0f)).*(exp(-2.*abs(kZI).*dm)-1)-(E0b.*conj(E0b)).*(exp(2.*abs(kZI).*dm)-1))-2.*kZI.*imag(E0f.*conj(E0b).*(exp(-2*1i*kZR.*dm)-1)));
      
      % absorption2 = -real(((-kZR+i*kZI).*(-(E0f.*conj(E0f)).*(exp(2.*kZI.*dm)-1)+(E0b.*conj(E0b)).*(exp(-2.*kZI.*dm)-1)+E0f.*conj(E0b).*(exp(-2*i*kZR.*dm)-1)-E0b.*conj(E0f).*(exp(2*i*kZR.*dm)-1))))
      
      % absorption2 = -(kZR.*((E0f.*conj(E0f)).*(exp(-2.*abs(kZI).*dm)-1)-(E0b.*conj(E0b)).*(exp(2.*abs(kZI).*dm)-1))-2.*kZI.*imag(E0f.*conj(E0b).*(exp(-2*i*kZR.*dm))))
      
      % absorption3 = -(kZR.*((E0f.*conj(E0f)).*(exp(2.*kZI.*dm)-1)-(E0b.*conj(E0b)).*(exp(-2.*kZI.*dm)-1))+2.*kZI.*real(E0f.*conj(E0b)).*(sin(2*kZR.*dm)-1))
      % absorption2 = -(kZR.*((E0f.*conj(E0f)).*(exp(2.*kZI.*dm)-1)-(E0b.*conj(E0b)).*(exp(-2.*kZI.*dm)-1))+2.*kZI.*real(E0f.*conj(E0b)).*(sin(2*kZR.*dm)))
      
      % absorption2 = -(kZR.*(E0f.*conj(E0f).*exp(-2.*abs(kZI).*dm)-E0b.*conj(E0b).*exp(2.*abs(kZI).*dm))-2.*kZI.*imag(E0f.*conj(E0b).*exp(-2*i*kZR.*dm)))
      % simResults.As2 = absorption2./(kZ0.*A.*conj(A));
      % simResults.As2Total = simResults.As2*(lightInfo.intensity)/lightInfo.intensityTotal;
      
      % prefix = kZ0/(kZI*kZR)*(nR*nI/n0);
      
      % initAbsorption = ;
      % initAbsorption =
      denominator = ones(size(kZ, 1), 1)*(kZ0.*(A.*conj(A)));
      absorptionResult = (absorption./denominator)';
      % looking for absorption = 4.568992010477310e+007
      %tm.SimulationResultsTE.set_versus_wavelength('Absorption', tm.SolarSpectrum.Wavelength, As);

      %tm.AsIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
      %  tm.SolarSpectrum.Energy,As);
      
      %AsTotal = As*(lightInfo.intensity)/lightInfo.intensityTotal;
      
      % use lightInfo.kVec, each row corresponds to some wavelength and
      
      % absorption = (2*cos(lightInfo.kVec(wavelengthIndex, tIndex).*structureInfo.tVector(tVectorIndex, tIndex)).*sin(lightInfo.kVec(wavelengthIndex, tIndex).*structureInfo.tVector(:, tIndex)).*simResults.coeffS(wavelengthIndex, tVectorIndex, 1, tIndex)'.*simResults.coeffS(wavelengthIndex, tVectorIndex, 2, tIndex)'+lightInfo.kVec(wavelengthIndex, tIndex).*structureInfo.tVector(tVectorIndex, tIndex).*simResults.coeffS(wavelengthIndex, tVectorIndex, 1, tIndex)'.^2+lightInfo.kVec(wavelengthIndex, tIndex)*structureInfo.tVector(:, tIndex).*simResults.coeffS(wavelengthIndex, tVectorIndex, 2, tIndex)'.^2)./lightInfo.kVec(wavelengthIndex, tIndex);
      % absorption = real(2*imag(structureInfo.nTable(wavelengthIndex, tIndex))./lightInfo.c*absorption);
      
      % I =
    end

    function [tm] = calculate_transmission(tm)
      [transmissionResultsTE] = calculate_transmission_from_coeffs(tm, tm.CoeffS);
      tm.SimulationResultsTE.set_versus_wavelength('Transmission', tm.SolarSpectrum.Wavelength, transmissionResultsTE);
      tm.TsIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy, transmissionResultsTE);
      
      [transmissionResultsTM] = calculate_transmission_from_coeffs(tm, tm.CoeffP);
      tm.SimulationResultsTM.set_versus_wavelength('Transmission', tm.SolarSpectrum.Wavelength, transmissionResultsTM);
      
      tm.TpIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy, transmissionResultsTM);
    end

    function [transmissionResults] = calculate_transmission_from_coeffs(tm, coeff)
      
      AS = coeff(:, 1, 1)';
      tS = 1./AS; % 0.45401558454591 + 0.25068364498564i
      
      prefactor = tm.N(:, tm.NumLayers).*cos(tm.ThetaLayers(:, tm.NumLayers))./(tm.N(:, 1).*cos(tm.ThetaLayers(:, 1)));
      transmissionResults = prefactor.*(abs(tS).^2)';
  
    end

    function [tm] = calculate_reflection(tm)
      [reflectionResultsTE] = TransferMatrixSimulation.calculate_reflection_from_coeffs(tm.CoeffS);
      tm.SimulationResultsTE.set_versus_wavelength('Reflection', tm.SolarSpectrum.Wavelength, reflectionResultsTE);
      tm.RsIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy, reflectionResultsTE);
      
      [reflectionResultsTM] = TransferMatrixSimulation.calculate_reflection_from_coeffs(tm.CoeffP);
      tm.SimulationResultsTM.set_versus_wavelength('Reflection', tm.SolarSpectrum.Wavelength, reflectionResultsTM);
      tm.RpIntegrated = SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
        tm.SolarSpectrum.Energy, reflectionResultsTM);
    end
    
    
    function [coeffS, coeffP] = simulate_wavelengths(tm)
      coeffS = zeros(tm.NumWavelengths, 2, tm.NumLayers);
      coeffP = zeros(tm.NumWavelengths, 2, tm.NumLayers);
      for indexLambda = 1:tm.NumWavelengths
        [coeffS(indexLambda, 1:2, 1:tm.NumLayers), ...
          coeffP(indexLambda, 1:2, 1:tm.NumLayers)] = ...
          CalculateMMatrixFast(tm, indexLambda);
      end
    end
    
    
    function [coeffS, coeffP] = CalculateMMatrixFast(tm, indexLambda)
      
      coeffS = zeros(2, tm.NumLayers);
      coeffP = zeros(2, tm.NumLayers);
      index = tm.NumLayers;
      %       if strcmp(tm.ThinFilmLayers(index).get_material, 'PEC')
      %         coeffS(:, tm.NumLayers) = [0; 0]; % no transmission or reflection from last layer
      %         coeffP(:, tm.NumLayers) = [0; 0]; % no transmission or reflection from last layer
      %       else
      coeffS(:, tm.NumLayers) = [1; 0]; % no reflection from last layer
      coeffP(:, tm.NumLayers) = [1; 0]; % no reflection from last layer
      %      end

      
      
      %       if strcmp(tm.ThinFilmLayers(index).get_material, 'PEC')
      %         Ds = [0 0;
      %           0 0];
      %         Dp = [0 0;
      %           0 0];
      %       else
      Ds = [1 1;
        tm.N(indexLambda, index)*cos(tm.ThetaLayers(indexLambda, index)) -tm.N(indexLambda, index)*cos(tm.ThetaLayers(indexLambda, index))];
      Dp = [cos(tm.ThetaLayers(indexLambda, index)) cos(tm.ThetaLayers(indexLambda, index));
        tm.N(indexLambda, index) -tm.N(indexLambda, index)];
%      end
      MsTemp = eye(2);
      MpTemp = eye(2);
      
      phi = tm.KLayers(indexLambda, :).*tm.Thicknesses;
      for index = tm.NumLayers-1:-1:2
        DsPrev = Ds;
        DpPrev = Dp;
        Ds = [1 1;
          tm.N(indexLambda, index)*cos(tm.ThetaLayers(indexLambda, index)) -tm.N(indexLambda, index)*cos(tm.ThetaLayers(indexLambda, index))];
        Dp = [cos(tm.ThetaLayers(indexLambda, index)) cos(tm.ThetaLayers(indexLambda, index));
          tm.N(indexLambda, index) -tm.N(indexLambda, index)];
        
        % phi(index) = lightInfo.kMat(lambdaIndex, index)*structureInfo.dm(index);
        P = [exp(1i*phi(index)) 0;
          0 exp(-1i*phi(index))];

        MsTemp = P/Ds*DsPrev*MsTemp;
        MpTemp = P/Dp*DpPrev*MpTemp;

%        MsTemp = P*inv(Ds)*DsPrev*MsTemp;
%        MpTemp = P*inv(Dp)*DpPrev*MpTemp;
        coeffS(:, index) = MsTemp*coeffS(:, tm.NumLayers);
        coeffP(:, index) = MpTemp*coeffP(:, tm.NumLayers);
        %    coeffs = MsTemp*coeffs(index, :);
      end
      
      index = 1;
      DsPrev = Ds;
      DpPrev = Dp;
      Ds = [1 1;
        tm.N(indexLambda, index)*cos(tm.ThetaLayers(indexLambda, index)) -tm.N(indexLambda, index)*cos(tm.ThetaLayers(indexLambda, index))];
      Dp = [cos(tm.ThetaLayers(indexLambda, index)) cos(tm.ThetaLayers(indexLambda, index));
        tm.N(indexLambda, index) -tm.N(indexLambda, index)];
      
      MsTemp = inv(Ds)*DsPrev*MsTemp;
      MpTemp = inv(Dp)*DpPrev*MpTemp;
      
      coeffS(:, index) = MsTemp*coeffS(:, tm.NumLayers);
      coeffP(:, index) = MpTemp*coeffP(:, tm.NumLayers);
    end
    
    function sheetResistance = calc_sheet_resistance(tfArray)      
    sheetResistance = ...
      tfArray.ThinFilmLayerArray.ThinFilmLayers(2).MD.Rho/...
      (tfArray.ThinFilmLayerArray.ThinFilmLayers(2).Thickness*...
      Constants.UnitConversions.NMtoM);  
    end
  
    function tm = calculate_transmission_and_reflectionTE(tm)
      %      tm.CoeffS = zeros(tm.SolarSpectrum.NumWavelength, 2, tm.ThinFilmLayerArray.NumLayers);
      %      tm.CoeffP = zeros(tm.SolarSpectrum.NumWavelength, 2, tm.ThinFilmLayerArray.NumLayers);
      
      tm.SimulationResultsTE = SimulationResults(tm.SolarSpectrum.Wavelength);
      %       .TransmissionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      %       tm.SimulationResultsTE.ReflectionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      
      phi = tm.KLayers(:, :).*(ones(tm.SolarSpectrum.NumWavelength, 1)*tm.Thicknesses.*Constants.UnitConversions.NMtoM);
      transmissionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      reflectionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      for indexWavelength = 1:tm.SolarSpectrum.NumWavelength
        
        index = length(tm.ThinFilmLayers);
        refractiveIndex = ...
          tm.N(indexWavelength, index);
        %         refractiveIndex = ...
        %             tm.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength);
        
        DsTerm = refractiveIndex.*...
          cos(tm.ThetaLayers(indexWavelength, index));
        
        Ds = [1 1;
          DsTerm -DsTerm];
        MsTemp = eye(2);
        
        for index = length(tm.ThinFilmLayers)-1:-1:2
          DsPrev = Ds;
          refractiveIndex = tm.N(indexWavelength, index);
          %            tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength);
          DsTerm = refractiveIndex.*...
            cos(tm.ThetaLayers(indexWavelength, index));
          Ds = [1 1;
            DsTerm -DsTerm];
          DsInverse = [1/2 1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)));
            1/2 -1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)))];
          
          % phi(index) = lightInfo.kMat(lambdaIndex, index)*structureInfo.dm(index);
          P = [exp(1i*phi(indexWavelength, index)) 0;
            0 exp(-1i*phi(indexWavelength, index))];
          
          MsTemp = P*DsInverse*DsPrev*MsTemp;
          %          coeffS(:, index) = MsTemp*tm.CoeffS(:, structureInfo.numLayersTotal);
          %          tm.CoeffP(:, index) = MpTemp*tm.CoeffP(:, structureInfo.numLayersTotal);
          %    coeffs = MsTemp*coeffs(index, :);
        end
        % do index = 1 outside of loop because no P term
        index = 1;
        refractiveIndex = ...
          tm.N(indexWavelength, index);
        
        DsPrev = Ds;
        DsInverse = [1/2 1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)));
          1/2 -1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)))];
        %         Ds = [1 1;
        %               DsTerm -Dsterm];
        %         Dp = [cos(tm.ThetaMat(indexWavelength, index)) cos(tm.ThetaMat(indexWavelength, index));
        %               tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength)...
        %               -tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength)];
        MsTemp = DsInverse*DsPrev*MsTemp;
        
        %       tm.CoeffS(:, index) = MsTemp*tm.CoeffS(:, structureInfo.numLayersTotal);
        %        tm.CoeffP(:, index) = MpTemp*tm.CoeffP(:, structureInfo.numLayersTotal);
        transmissionConstant = tm.N(indexWavelength, tm.NumLayers)*...
          cos(tm.ThetaLayers(tm.NumLayers))/...
          (tm.N(indexWavelength, 1)*...
          cos(tm.ThetaLayers(1)));
        
        %         transmissionConstant = tm.ThinFilmLayerArray.ThinFilmLayers(tm.ThinFilmLayerArray.NumLayers).MD.OpticalProperties.RefractiveIndex(indexWavelength)*...
        %           cos(tm.ThetaLayers(tm.ThinFilmLayerArray.NumLayers))/...
        %           (tm.ThinFilmLayerArray.ThinFilmLayers(1).MD.OpticalProperties.RefractiveIndex(indexWavelength)*...
        %           cos(tm.ThetaLayers(1)));
        transmissionResults(indexWavelength) = ...
          transmissionConstant*abs(1/MsTemp(1,1))^2;   % from s-mode
        reflectionResults(indexWavelength) = abs(MsTemp(2,1)/MsTemp(1,1))^2;   % from s-mode
      end
      
      tm.SimulationResultsTE.set_versus_wavelength('Transmission', tm.SolarSpectrum.Wavelength, transmissionResults);
      tm.SimulationResultsTE.set_versus_wavelength('Reflection', tm.SolarSpectrum.Wavelength, reflectionResults);
      tm.SimulationResultsTE.set_versus_wavelength('Absorption', tm.SolarSpectrum.Wavelength, 1 - transmissionResults - reflectionResults);
      
      if tm.SolarSpectrum.NumWavelength > 1
        % be careful, this assumes energy is the same
        [energy, transmission] = tm.SimulationResultsTE.get_versus_energy('Transmission');
        
        tm.TransmissionIntegrated = ...
          SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
          energy,transmission);
        [energy, reflection] = tm.SimulationResultsTE.get_versus_energy('Reflection');
        tm.ReflectionIntegrated = ...
          SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
          energy, reflection);
      else
        [energy, transmission] = tm.SimulationResultsTE.get_versus_energy('Transmission');
        tm.TransmissionIntegrated = transmission;
        [energy, reflection] = tm.SimulationResultsTE.get_versus_energy('Reflection');
        tm.ReflectionIntegrated = reflection;
      end
      tm.AbsorptionIntegrated = 1 - tm.TransmissionIntegrated - tm.ReflectionIntegrated;
    end
    
    
    
    
    function tm = calculate_transmission_and_reflection(tm)
%      tm.CoeffS = zeros(tm.SolarSpectrum.NumWavelength, 2, tm.ThinFilmLayerArray.NumLayers); 
%      tm.CoeffP = zeros(tm.SolarSpectrum.NumWavelength, 2, tm.ThinFilmLayerArray.NumLayers);

      tm.SimulationResultsTE.TransmissionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      tm.SimulationResultsTE.ReflectionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      tm.SimulationResultsTM.TransmissionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);
      tm.SimulationResultsTM.ReflectionResults = zeros(tm.SolarSpectrum.NumWavelength, 1);

%      coeffS = zeros(2, tm.ThinFilmLayerArray.NumLayers);
%      coeffP = zeros(2, tm.ThinFilmLayerArray.NumLayers);
      phi = tm.KLayers(:, :).*(ones(tm.SolarSpectrum.NumWavelength, 1)*tm.Thicknesses.*Constants.UnitConversions.NMtoM);

      for indexWavelength = 1:tm.SolarSpectrum.NumWavelength
%        tm.CoeffS(indexWavelength, structureInfo.numLayersTotal, 1:2, tm.ThinFilmLayerArray.NumLayers) = [1; 0];
%        tm.CoeffP(indexWavelength, structureInfo.numLayersTotal, 1:2, 
        
        index = tm.ThinFilmLayerArray.NumLayers;
        refractiveIndex = ...
            tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength);

        DsTerm = refractiveIndex.*...
          cos(tm.ThetaLayers(indexWavelength, index));

        Ds = [1 1;
          DsTerm -DsTerm];
        Dp = [cos(tm.ThetaLayers(indexWavelength, index)) cos(tm.ThetaLayers(indexWavelength, index));
          refractiveIndex -refractiveIndex];
        MsTemp = eye(2);
        MpTemp = eye(2);

        for index = tm.ThinFilmLayerArray.NumLayers-1:-1:2
          DsPrev = Ds;
          DpPrev = Dp;
          refractiveIndex = ...
            tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength);
          DsTerm = refractiveIndex.*...
              cos(tm.ThetaLayers(indexWavelength, index)); 
          
          Ds = [1 1;
              DsTerm -DsTerm];
          Dp = [cos(tm.ThetaLayers(indexWavelength, index)) cos(tm.ThetaLayers(indexWavelength, index));
              refractiveIndex -refractiveIndex];
          DsInverse = [1/2 1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)));
          1/2 -1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)))];
          DpInverse = [1/(2*cos(tm.ThetaLayers(indexWavelength, index))) 1/(2*refractiveIndex);
            1/(2*cos(tm.ThetaLayers(indexWavelength, index))) -1/(2*refractiveIndex)];

          % phi(index) = lightInfo.kMat(lambdaIndex, index)*structureInfo.dm(index);
          P = [exp(i*phi(indexWavelength, index)) 0;
              0 exp(-i*phi(indexWavelength, index))];

          MsTemp = P*DsInverse*DsPrev*MsTemp;
          MpTemp = P*DpInverse*DpPrev*MpTemp;
%          coeffS(:, index) = MsTemp*tm.CoeffS(:, structureInfo.numLayersTotal);
%          tm.CoeffP(:, index) = MpTemp*tm.CoeffP(:, structureInfo.numLayersTotal);
      %    coeffs = MsTemp*coeffs(index, :);
        end
        % do index = 1 outside of loop because no P term
        index = 1;
        refractiveIndex = ...
            tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength);
     
        DsPrev = Ds;
        DpPrev = Dp;
        DsInverse = [1/2 1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)));
          1/2 -1/(2*refractiveIndex*cos(tm.ThetaLayers(indexWavelength, index)))];
        DpInverse = [1/(2*cos(tm.ThetaLayers(indexWavelength, index))) 1/(2*refractiveIndex);
            1/(2*cos(tm.ThetaLayers(indexWavelength, index))) -1/(2*refractiveIndex)];        
%         Ds = [1 1;
%               DsTerm -Dsterm];
%         Dp = [cos(tm.ThetaMat(indexWavelength, index)) cos(tm.ThetaMat(indexWavelength, index));
%               tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength)...
%               -tm.ThinFilmLayerArray.ThinFilmLayers(index).MD.OpticalProperties.RefractiveIndex(indexWavelength)];
        MsTemp = DsInverse*DsPrev*MsTemp;
        MpTemp = DpInverse*DpPrev*MpTemp;
                
         %       tm.CoeffS(:, index) = MsTemp*tm.CoeffS(:, structureInfo.numLayersTotal);
%        tm.CoeffP(:, index) = MpTemp*tm.CoeffP(:, structureInfo.numLayersTotal);
        
        transmissionConstant = tm.ThinFilmLayerArray.ThinFilmLayers(tm.ThinFilmLayerArray.NumLayers).MD.OpticalProperties.RefractiveIndex(indexWavelength)*...
          cos(tm.ThetaLayers(tm.ThinFilmLayerArray.NumLayers))/...
          (tm.ThinFilmLayerArray.ThinFilmLayers(1).MD.OpticalProperties.RefractiveIndex(indexWavelength)*...
          cos(tm.ThetaLayers(1)));
        tm.SimulationResultsTE.TransmissionResults(indexWavelength) = ...
          transmissionConstant*abs(1/MsTemp(1,1))^2;   % from s-mode
        tm.SimulationResultsTM.TransmissionResults(indexWavelength) = ...
          transmissionConstant*abs(1/MpTemp(1,1))^2;
        tm.SimulationResultsTE.ReflectionResults(indexWavelength) = abs(MsTemp(2,1)/MsTemp(1,1))^2;   % from s-mode
        tm.SimulationResultsTM.ReflectionResults(indexWavelength) = abs(MpTemp(2,1)/MpTemp(1,1))^2;
      end
      if tm.SolarSpectrum.NumWavelength > 1
        tm.TransmissionIntegrated = ...
            SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
            tm.SolarSpectrum.Energy,...
            tm.SimulationResultsTE.TransmissionResults);
        tm.ReflectionIntegrated = ...
            SolarCell.calculate_integrated_data(tm.SolarSpectrum,...
            tm.SolarSpectrum.Energy,...
            tm.SimulationResultsTE.ReflectionResults);
      else
        tm.TransmissionIntegrated = tm.SimulationResultsTE.TransmissionResults;
        tm.ReflectionIntegrated = tm.SimulationResultsTE.ReflectionResults;
      end
    end
    

    function thicknesses = get.Thicknesses(tm)
      thicknesses = zeros(1, length(tm.ThinFilmLayers));
      for i = 1:length(tm.ThinFilmLayers)
        thicknesses(i) = tm.ThinFilmLayers(i).Thickness;
      end
    end
    
    function tm = calculate_theta_and_k_vector(tm)
      % reaching pretty far down; 
      % 
      beta = tm.N(:, 1).*...
        2*pi./(Constants.UnitConversions.NMtoM*tm.SolarSpectrum.Wavelength).*sin(tm.Theta);      
%       beta = tm.ThinFilmLayers(1).Material.OpticalProperties.N.*...
%         2*pi./(Constants.UnitConversions.NMtoM*tm.SolarSpectrum.Wavelength).*sin(tm.Theta);
      tm.ThetaLayers = zeros(tm.SolarSpectrum.NumWavelength, length(tm.ThinFilmLayers));
      tm.KLayers = zeros(tm.SolarSpectrum.NumWavelength, length(tm.ThinFilmLayers));
      for i = 1:tm.NumLayers
%         tm.ThetaLayers(:, i) = asin(Constants.UnitConversions.NMtoM.*tm.SolarSpectrum.Wavelength./(2*pi).*beta./...
%           tm.ThinFilmLayers(i).Material.OpticalProperties.RefractiveIndex);
        tm.ThetaLayers(:, i) = asin(Constants.UnitConversions.NMtoM.*tm.SolarSpectrum.Wavelength./(2*pi).*beta./...
          tm.N(:, i));
        %structureInfo.nTable(:, i)); % this is in radians
        tm.KLayers(:, i) = 2*pi*...
          tm.N(:, i)./...
          tm.SolarSpectrum.Wavelength.*cos(tm.ThetaLayers(:, i));       
%         tm.KLayers(:, i) = 2*pi*...
%           tm.ThinFilmLayers(i).Material.OpticalProperties.RefractiveIndex./...
%           (Constants.UnitConversions.NMtoM.*tm.SolarSpectrum.Wavelength).*cos(tm.ThetaLayers(:, i));
      end
    end
        
    function tm = structure_preprocessing(tm)
      % this sets all the optical properties N and K at the wavelengths of 
      % solar spectrum
      tm.ThinFilmLayers.adjust_optical_properties(tm.SolarSpectrum.Wavelength);
    end
    
   

    
  end
  
  methods(Static, Hidden=true)
    function [reflectionResults] = calculate_reflection_from_coeffs(coeff)
      
      AS = coeff(:, 1, 1)';
      BS = coeff(:, 2, 1)';
      rS = BS./AS; % 0.45401558454591 + 0.25068364498564i
      reflectionResults = (abs(rS).^2)';
      
    end
  end
  
  methods(Static)
    test()
    test2()
    
    test5()
    
    function [tma] = create_array(solarSpectrum, materials, va)
      tma = TransferMatrixSimulation.empty(va.NumValues, 0);
      if length(materials) ~= va.NumVariables + 2
        error('Number of materials should be two more than number of variables');
      end
      for i = 1: va.NumValues
        thicknesses = [0 va.Values(i, :) 0];
        tfArray = ThinFilmLayer.create_array(materials, thicknesses);
        tma(i) = TransferMatrixSimulation(solarSpectrum, tfArray);
      end
    end
  end
  
  
end

