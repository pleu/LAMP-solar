clear;
frequency = linspace(Photon.convert_wavelength_to_frequency(280), Photon.convert_wavelength_to_frequency(2000));
thetaArray = [0:10:90]';

data = linspace(0, 1, length(frequency));

mo = Monitor.empty(length(thetaArray), 0);
for i = 1:length(thetaArray)
  data = frequency./max(frequency).*exp(-(frequency./max(frequency).^2-(thetaArray(i)./max(thetaArray)).^2));
  mo(i) = Monitor('Absorption', frequency, data);
end

dataMatrix = vertcat(mo.Data);

figure(1);
clf;
contourf(thetaArray', frequency, dataMatrix', 100, 'LineStyle', 'none')

thetaQuery = linspace(0, 90);
frequencyQuery = linspace(min(frequency), max(frequency), 200);

frequencyMatrix = repmat(frequency, length(thetaArray), 1);

f_simArray = mean(frequencyMatrix, 2);

thetaActual = real(180/pi*asin(repmat(f_simArray, 1, size(frequency, 2)).*...
  sin(repmat(thetaArray, 1, size(frequency, 2)).*pi/180)./frequencyMatrix));

%[moQuery] = mo.query_monitor_data(thetaActual, thetaQuery, frequencyQuery);