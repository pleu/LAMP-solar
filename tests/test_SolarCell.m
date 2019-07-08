function test_SolarCell

local_path = get_LAMPsolar_option('LAMPsolar_path');
run(fullfile(local_path, 'solar_analysis', 'examples', 'general analysis', 'simulate_solar_cell'));
