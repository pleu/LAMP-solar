function test_FDTDSimulationResults

local_path = get_LAMPsolar_option('LAMPsolar_path');
run(fullfile(local_path, 'solar_analysis', 'examples', 'thin film angle dependence', 'analyze_thin_film_array_results'));
