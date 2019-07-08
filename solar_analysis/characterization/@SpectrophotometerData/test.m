clear;
filename = 'CuNm-3.5um-200s';
sd = SpectrophotometerData(filename);

sd.get_data_at_wavelength(220);

figure(1);
clf;
sd.TransmissionTotal.plot_versus_wavelength();

figure(2);
clf;
sd.Haze.plot_versus_wavelength();
