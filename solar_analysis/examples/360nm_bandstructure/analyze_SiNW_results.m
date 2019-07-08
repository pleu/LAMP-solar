function [] = analyze_SiNW_results()
%ANALYZE_SINW_RESULTS
% Plot the bandstructure of one certain nanowire structure
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Baomin Wang
% LAMP, University of Pittsburgh
filename = 'bandstructure360nm_';

figure(1);
clf;
sr = BandStructureResults(filename);
sr.plot_frequency_versus_wavevector;

gtext('Lightline');
set(gca,'XTick',[0 0.5 1.0 max(axis)]);
set(gca,'Fontname','Symbol');
set(gca,'XTickLabel',{'G'; 'C'; 'M'; 'G'});

figure(2);
clf;
sr = BandStructureResults(filename);
sr.plot_energyresults_versus_wavevector;

gtext('Lightline');
set(gca,'XTick',[0 0.5 1.0 1.707]);
set(gca,'Fontname','Symbol');
set(gca,'XTickLabel',{'G'; 'C'; 'M'; 'G'});