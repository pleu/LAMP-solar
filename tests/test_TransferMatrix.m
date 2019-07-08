function test_TransferMatrix

local_path = get_LAMPsolar_option('LAMPsolar_path');
run(fullfile(local_path, 'solar_analysis', 'examples', 'Ag thin film transfer matrix', 'Ag_thin_film_simulation'));
