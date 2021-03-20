classdef Photon < handle
% Photon class
% 
% See also SolarSpectrumArray
%
% Copyright 2011
% Paul Leu
  properties
    Wavelength; % in nm
  end

  properties(Dependent = true)
    Energy; % in eV
    Frequency; % in Hz (1/sec)
    AngularFrequency; % in radians/sec
    Wavenumber; % this is k (1/nm)
    
  end
  
  methods
    function ph = Photon(wavelength)
    % Constructor
      if nargin > 0
        ph.Wavelength = wavelength;
      end
    end
    
    function set.Energy(ph, energy)
      ph.Wavelength = Photon.ConvertEnergyToWavelength(energy);
    end
        
    function set.Frequency(ph, frequency)
      ph.Wavelength = Photon.ConvertFrequencyToWavelength(frequency);
    end
    
    function set.AngularFrequency(ph, angularFrequency)
      ph.Wavelength = Photon.ConvertFrequencyToWavelength(angularFrequency/(2*pi));
    end
    
    function wavenumber = get.Wavenumber(ph)
      wavenumber = Photon.convert_wavelength_to_wavenumber(ph.Wavelength);
    end

    
    function energy = get.Energy(ph)
      energy = Photon.ConvertWavelengthToEnergy(ph.Wavelength);
    end
    
    function frequency = get.Frequency(ph)
      frequency = Photon.ConvertWavelengthToFrequency(ph.Wavelength);
    end
    
    function angularFrequency = get.AngularFrequency(ph)
      angularFrequency = Photon.convert_wavelength_to_angular_frequency(ph.Wavelength);
    end
    
  end
  
  methods(Static)
    [angularFrequency] = convert_wavenumber_to_angular_frequency(wavenumber)

    [wavenumber] = convert_wavelength_to_wavenumber(wavelength)  

    [angularFrequency] = convert_wavelength_to_angular_frequency(wavelength)
    
    [wavelength] = convert_angular_frequency_to_wavelength(angular_frequency)
    
    [energy] = ConvertFrequencyToEnergy(frequency)  
    
    [wavelength] = ConvertEnergyToWavelength(energy)
    % converts from eV to nm 
    
    [wavelength] = ConvertFrequencyToWavelength(frequency)
    % Convert frequency in 1/sec to Wavelength in nm
    
    [frequency] = ConvertWavelengthToFrequency(wavelength)
    
    [energy] = ConvertWavelengthToEnergy(wavelength)  

    [wavenumber] = convert_angular_frequency_to_wavenumber(angularFrequency)
    
    [energy] = convert_wavenumber_to_energy(wavenumber)
    
    [energy] = convert_wavelength_to_energy(wavelength)
    
    [frequency] = convert_energy_to_frequency(energy) 
    
    [frequency] = convert_wavelength_to_frequency(wavelength) 
    
    [wavenumber] = convert_frequency_to_wavenumber(frequency) 
    
    [wavelength] = convert_energy_to_wavelength(energy)
    
    [wavelength] = convert_frequency_to_wavelength(frequency)
    
    [frequency] = convert_wavenumber_to_frequency(wavenumber) 
    
    [wavelength] = convert_wavenumber_to_wavelength(wavenumber)
    
    test()
  end
  
end

