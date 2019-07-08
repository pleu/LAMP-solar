 function add_energy_top_axis(energies, energyLabels)
  if nargin == 0
    energies = [0.5 1 2 3 4];
    energyLabels = {'0.5', '1', '2', '3', '4'};
  end
 
  wavelengths = Photon.ConvertEnergyToWavelength(energies);
  %LinkTopAxisData(energies, wavelengthLabels, 'Wavelength (nm)');
  [wavelengths, ind] = sort(wavelengths);
  %linkTopAxisData(energies, wavelengthLabels(ind), 'Wavelength (nm)');

  %oldAxis = gca;
  link_top_axis_data(wavelengths, energyLabels(ind), 'Energy (eV)');
  %LinkTopAxisData(wavelengths, energyLabels(ind), 'Energy (eV)');

  %axis([get(gca,'Xlim') get(gca,'Ylim')]);
  %      set(hAxes(2), 'XTick', TopTickPositions, 'Layer', 'top');
%      set(hAxes(2), 'YTickLabel', '')
%      set(hAxes(2), 'XTickLabel', TopTickLabels, 'Layer', 'top');
end
