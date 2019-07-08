diameter = 130;
pitch = 200;
thickness = 120;
wavelengthIndex = 1;
sliceValue = 0;
area = (200e-9)^2;

ss = SolarSpectrum.global_AM1p5;

irradiance = interp1(ss.Wavelength, ss.Irradiance, fr.Wavelength(wavelengthIndex)); % in W/m^2


filename = ['ThinFilmp200nmTotal'];
fr = FieldResults.create_scalar(filename, 'Pabs');
clf;
fr.X = fr.X * Constants.UnitConversions.MtoNM;
fr.Y = fr.Y * Constants.UnitConversions.MtoNM;
fr.Z = -fr.Z * Constants.UnitConversions.MtoNM;
%fr.OutputObj.Value = fr.OutputObj.Value./(Constants.UnitConversions.MtoNM^3);
fr.OutputObj.Value = irradiance*area*fr.OutputObj.Value/(Constants.UnitConversions.MtoCM^3)/(Constants.LightConstants.Q*Photon.ConvertWavelengthToEnergy(fr.Wavelength(wavelengthIndex)));
fr.OutputObj.Value(fr.OutputObj.Value==-Inf) = 0


%fr.OutputObj.Value = log10(irradiance*area*fr.OutputObj.Value/(Constants.UnitConversions.MtoCM^3)/(Constants.LightConstants.Q*Photon.ConvertWavelengthToEnergy(fr.Wavelength(wavelengthIndex))));
% fr.OutputObj.Value(fr.OutputObj.Value==-Inf) = 0


%maximum around 825
%fr.contour_slice('x', find(fr.Y == 0), 'y', 19);
fr.contour_slice( 'x', find(round(fr.Y) == sliceValue),'y', wavelengthIndex);

caxis([0 1e20]);
colorbar('YTick', [0:2e19:10e19],'YTickLabel', {'0', '0.2', '0.4', '0.6', '0.8', '1.0'});

text(140, 190, 'x 10^{-19}', 'FontName', 'Verdana');
%colorbar off;

hold on;  
plot([-pitch/2 pitch/2],[thickness thickness],'w--');
plot([-pitch/2 pitch/2],[0 0],'w--');

%plot([0 0], [-thickness thickness*2],'k-', 'LineWidth', 6);


xlabel('nm');
ylabel('nm');
title('P_{abs}');
axis image;

hold on;

