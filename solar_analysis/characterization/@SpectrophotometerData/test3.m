clear;
filename = 'CuNm-3.5um-200s';
sd = SpectrophotometerData(filename);

%sd.remove_wavelength_range(
sd = sd.remove_data_wavelength_range('TransmissionTotal', 831, 870); 


figure(1);
clf;
sd.TransmissionTotal.plot_versus_wavelength();

figure(2);
clf;
sd.Haze.plot_versus_wavelength();
