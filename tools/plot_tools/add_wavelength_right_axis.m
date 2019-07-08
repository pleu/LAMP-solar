function add_wavelength_right_axis(wavelengths, wavelengthLabels)
  energies = Photon.ConvertWavelengthToEnergy(wavelengths);
  %LinkTopAxisData(energies, wavelengthLabels, 'Wavelength (nm)');
  [energies, ind] = sort(energies);
  %linkTopAxisData(energies, wavelengthLabels(ind), 'Wavelength (nm)');

  position = get(gca, 'Position');
  position(3) = 0.6;
  set(gca, 'Position', position);

  link_right_axis_data(energies, wavelengthLabels(ind), 'Wavelength (nm)');

end
