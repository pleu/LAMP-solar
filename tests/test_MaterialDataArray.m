function test_MaterialDataArray
% Plots the absorption coefficient for an array of materials.
% 
% Copyright 2011
% Paul Leu

local_path = get_LAMPsolar_option('LAMPsolar_path');
run(fullfile(local_path, 'help', 'latex', 'Figures', 'plot_optical_properties_for_array'));

