function test_StepFunctionAbsorbers
% tests Lamberian and 
local_path = get_LAMPsolar_option('LAMPsolar_path');
run(fullfile(local_path, 'help', 'latex', 'Figures', 'plot_ultimate_efficiency_as_function_of_bandgap'));
