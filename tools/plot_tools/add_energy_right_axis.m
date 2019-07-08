function add_energy_right_axis(energies,energyLabels)
  wavelengths = Photon.ConvertEnergyToWavelength(energies);
  %LinkTopAxisData(energies, wavelengthLabels, 'Wavelength (nm)');
  [wavelengths, ind] = sort(wavelengths);
  %linkTopAxisData(energies, wavelengthLabels(ind), 'Wavelength (nm)');
% 
%   position = get(gca, 'Position');
%   position(3) = 0.6;
%   set(gca, 'Position', position);

  link_right_axis_data(wavelengths, energyLabels(ind), 'Energy (eV)');
  

end

