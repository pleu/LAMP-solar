function [] = test()
clear;
heightArray = [0, 0.8 ,1.7];
va = VariableArray({'h'}, {'um'}, heightArray);

va.create_filenames('', '-');

%filenames = {'0um-', '0.8um-', '1.7um-'};
sd = SpectrophotometerData.read_array(va.Filenames);

sa = SpectrophotometerDataArray(sd, va);

figure(1);
clf;
%sa.contour

%sa.contour('Wavelength', 'h', 'TransmissionTotal')
sa.contour('Wavelength', 'h', 'TransmissionTotal', 200, 0)

figure(2);
clf;
sa.contour('Wavelength', 'h', 'Haze', 200, 0)
%sa.contour('Wavelength', 'h', 'Haze')

