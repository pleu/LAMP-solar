function test_SolarSpectrum

local_path = get_LAMPsolar_option('LAMPsolar_path');
run(fullfile(local_path, 'help', 'latex', 'Figures', 'plot_solar_spectrum_with_blackbody'));
