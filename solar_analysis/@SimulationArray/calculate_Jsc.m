function [sc] = calculate_Jsc(sa, ma, ss)
% Calculate J_sc at theta = 0 and phi = 0
[q, idx] = ismember([0 0], sa.VariableArray.Values, 'rows');
%sa.VariableArray.Values == [0 0]

minWavelength = round(min(sa.Simulations(1).AbsorptionResults.Wavelength)); % round because some slight numerical error
maxWavelength = round(max(sa.Simulations(1).AbsorptionResults.Wavelength));
ss.truncate_spectrum_wavelength(minWavelength, maxWavelength);

%material = MaterialType.create('Si');
sc = SolarCell(ss, sa.Simulations(idx), ma);
