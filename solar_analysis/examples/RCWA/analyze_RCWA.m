clear;
filename = 'S4-TM.out';
%rc = RCWASimulationResultsArray(filename);

sa = SimulationArray.read_RCWA_file(filename);

% figure(1);
% clf;
% sa2 = sa.get_sub_simulation_array('Phi', 0);
% sa2.contour('Wavelength', 'Theta', 'Absorption',200,0);
% caxis([0 1]);
% 
% figure(2);
% clf;
% %sa3 = sa.get_sub_simulation_array('Theta', 0);
% sa2.contour('Wavelength', 'Theta', 'Absorption',200,0, 'polar');
% caxis([0 1]);
% 
% 
% figure(3);
% clf;
% sa3 = sa.get_sub_simulation_array('Theta', 0);
% sa3.contour('Wavelength', 'Phi', 'Absorption',200,0);
% caxis([0 1]);
% % 



figure(4);
clf;
simResults = sa.get_values_at_wavelength(800);
mo = [simResults.AbsorptionResults];
data = [mo.Data];
data(sa.VariableArray.Values(:, 1) == 90) = nan;
sa.VariableArray.contour('Theta', 'Phi', data, 900, 'linear');
caxis([0 1]);

figure(5);
clf;
sa.VariableArray.contour('Theta', 'Phi', data, 900, 'linear', 'polar');
caxis([0 1]);

% caxis([0 1]);


%figure(4);




% 
% 
% 

%rc.contour('Wavelength', 'Theta', 'Absorption',200,0, 'polar');
