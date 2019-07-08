function add_wavelength_top_axis(wavelengths, wavelengthLabels)
  
  if nargin == 0
    wavelengths = [200 300 400 500 600 700 800 900 1000 2000 3000 4000];
    wavelengthLabels = {'200', '', '400', '', '600', '', '', '', '1000', '', '', '4000'};
  end
  energies = Photon.ConvertWavelengthToEnergy(wavelengths);
  %LinkTopAxisData(energies, wavelengthLabels, 'Wavelength (nm)');
  [energies, ind] = sort(energies);
  %linkTopAxisData(energies, wavelengthLabels(ind), 'Wavelength (nm)');

 

  link_top_axis_data(energies, wavelengthLabels(ind), 'Wavelength (nm)');

end

