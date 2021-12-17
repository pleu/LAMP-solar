classdef SolarSpectrum < handle
% SOLARSPECTRUM class for solar spectrum
% 
% See also SolarSpectrumArray
%
% Copyright 2011
% Paul Leu
  properties
    Name
  end
  properties (SetAccess = private)
    SpectrumPhoton;
    Irradiance;    % irradiance of solar spectrum (W/m^2*nm^-1)
    PowerDensityUntruncated;  % power density (W/m^2)
    NumPhotonsUntruncated; % # of photons/m^2*sec^(-1)
  end
  
  properties (SetAccess = private, Dependent = true)
    Wavelength;
    Energy;  % eV
    Frequency; % in Hz
    PowerDensity;  % power density (W/m^2)
    IrradianceEnergy;    % irradiance (W/m^2*eV^-1)
    PhotonFlux; % # of photons/m^2*sec^(-1)*eV^-1
    PhotonFluxNM; % # of photons/m^2*sec^(-1)*nm^(-1)
    NumWavelength; % # of wavelengths
    NumPhotons; % # of photons/m^2*sec^(-1)
  end
  
  methods    
    function obj = SolarSpectrum(Name,wavelength,irradiance)
    % Constructor
      if nargin > 0
        obj.Name = Name;
%        obj.Wavelength = wavelength;
        obj.Irradiance = irradiance;
        obj.SpectrumPhoton = Photon(wavelength);
        obj.PowerDensityUntruncated = obj.PowerDensity;
        if length(wavelength) > 1
          obj.NumPhotonsUntruncated = -trapz(obj.Energy, obj.PhotonFlux);
        else
          obj.NumPhotonsUntruncated = obj.PhotonFlux;
        end
      end
    end
    
    
    
    function obj = setSpectrumEnergy(energy, irradiance)
      obj.Frequency = energy;
      obj.Irradiance = irradiance;       
    end

    function obj = setSpectrumFrequency(frequency, irradiance)
      obj.Frequency = frequency;
      obj.Irradiance = irradiance;       
    end
    
    function set.Frequency(obj, frequency)
      obj.Wavelength = Photon.ConvertEnergyToWavelength(frequency);      
    end
    
    function set.Energy(obj, energy)
      obj.Wavelength = Photon.ConvertEnergyToWavelength(energy);      
    end
    
    function set.Wavelength(obj, wavelength)
      obj.SpectrumPhoton.Wavelength = wavelength; 
    end
    
    function numWavelength = get.NumWavelength(obj)
      numWavelength = length(obj.Wavelength);
    end
    
    function numPhoton = get.NumPhotons(obj)
      numPhoton = -trapz(obj.Energy, obj.PhotonFlux);
    end
    
    function powerDensity = get.PowerDensity(obj)
      if length(obj.Wavelength) == 1
        powerDensity = 0;
      else
        powerDensity = trapz(obj.Wavelength, obj.Irradiance);
      end
    end
    
    function photonFlux = get.PhotonFlux(obj)
      photonFlux = obj.IrradianceEnergy./obj.Energy./Constants.LightConstants.Q;
    end
    
    function PhotonFluxNM = get.PhotonFluxNM(obj)
      PhotonFluxNM = obj.Irradiance./obj.Energy./Constants.LightConstants.Q; 
    end
    
    function wavelength = get.Wavelength(obj)
      wavelength = obj.SpectrumPhoton.Wavelength;
    end

    function frequency = get.Frequency(obj)
      frequency = obj.SpectrumPhoton.Frequency;
    end

    function energy = get.Energy(obj)
      energy = obj.SpectrumPhoton.Energy;
    end
        
    function irradianceEnergy = get.IrradianceEnergy(obj)
      irradianceEnergy = obj.Irradiance*Constants.LightConstants.HC./(obj.Energy).^2;
    end    
    
    function shortCircuitCurrent = calc_max_short_circuit_current(obj, bandGap, upperLimit)
      % This is in units of Amps/m^2
      indBottom = find(obj.Energy == bandGap, 1);
      energyInd = find(obj.Energy >= bandGap);
      if ~isempty(indBottom)
        energies = obj.Energy(energyInd);
        photonFluxes = obj.PhotonFlux(energyInd);
      else
        energies = [obj.Energy(energyInd); bandGap];
        photonFluxes = [obj.PhotonFlux(energyInd); interp1(obj.Energy, obj.PhotonFlux, bandGap)];
      end
      if nargin == 3
        indTop = find(obj.Energy == upperLimit, 1);
        energyInd = find(energies <= upperLimit);
        if ~isempty(indTop)
          energies = energies(energyInd);
          photonFluxes = photonFluxes(energyInd);
        else
          energies = [upperLimit; energies(energyInd)];
          photonFluxes = [interp1(obj.Energy, obj.PhotonFlux, upperLimit); obj.PhotonFlux(energyInd)];
        end
      end
      shortCircuitCurrent = -Constants.LightConstants.Q*...
          trapz(energies, photonFluxes);
    end
  end
  
  methods(Static) 
    
    F0 = calc_qF0(bandGap, n)

    obj = create_single_wavelength(wavelength)
    
    irradianceEnergy = convert_photon_flux_to_irradiance_energy(photonFlux, energy)
      
    photonFlux = convert_irradiance_to_photon_flux(irradiance, energy)
    
    irradiance = convert_irradiance_energy_to_irradiance(irradianceEnergy, energy)

    solarSpectrum = CIEphotopic()

    solarSpectrum = read_CIE()

    
    solarSpectrum = AM0()
    % Reads in AM0 data 
    
    solarSpectrum = global_AM1p5()
    % Reads in Global AM1.5 data 
    
    solarSpectrum = direct_AM1p5()
    % Reads in direct AM1.5 data 
    
    solarSpectrum = create_blackbody_spectrum(temperature, wavelength)
    %CREATE_BLACKBODY_SPRECTRUM
    
    solarSpectrum = read_ASTMG173(option)
    % READ_ASTMG173 
    % Reads in ASTMG173 data 
    
    
    bn = calculate_bn_lambda(lambda, n, temperature, F)
    
    bn = calculate_bn(energy, n, delMu, temperature, F)
    % CALCULATE_BN
    % Equation 2.12 in Nelson, Physics of Solar Cells
    % Calculates the emitted photon flux density of blackbody (in 
    % # of photons/m^2*sec^(-1)*eV^-1)
    % 
    % See also

    be = calculate_be_omega(energy, delMu, temperature)
    % CALCULATE_BE_OMEGA
    % Equation 2.14 in Nelson, Physics of Solar Cells without geometrical
    % factor
    % Calculates the emitted photon flux density (in 
    % # of photons/m^2*sec^(-1)*eV^-1)
    % 
    % See also
    
    be = calculate_be(energy, delMu, temperature, F)
    % CALCULATE_BE 
    % Equation 2.14 in Nelson, Physics of Solar Cells
    % Calculates the emitted photon flux density (in 
    % # of photons/m^2*sec^(-1)*eV^-1)
    % 
    % See also
    
    test()
    % TEST
    % tests the SolarSpectrum class
    % 
    
    
    plot_limiting_efficiency_jsc_voc_versus_energy()
    
    test2()
    
    test3()
    
    test4()
    
    test5()
    
    test6()
    
    testArray()
    
    testArray2()
    
    test_ultimate_efficiency()
    
    test_limiting_efficiency()
    
    
    test_limiting_efficiency_tandem()
    
    solarSpectrumArray = read_ASTMG173_all()
    % READ_ASTMG173_ALL
    % Reads in all of ASTMG173 data
    
    solarSpectrumArray = create_solar_spectrum_array(numSpectrum)
    % CREATE_SOLAR_SPECTRUM_ARRAY
    % Creates the number of solar spectrum
        
  end
  
end

