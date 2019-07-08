function LAMPsolar_settings
% initialize LAMPsolar toolbox
% 
% This file contains some global settings
% to be set by the user. Please read carefully the predefined 
% settings and correct them if you experience troubles.


%% user defined global settings
%------------------------------------------------------------------------

%% default global plotting options
% here you can define default plot options

% default_plot_options = {'FontSize',26,...
%   'LineWidth', 3,...
%   'LineMarkerSize', 10};
% default_axes_options = {
%   'FontName', 'Helvetica',...
%   'TickLength', [0.04 0.05],...
%   'Box','on'}
% default_figure_options = {
%   'Color', [1 1 1],... 
%   'PaperPosition', [2.65 4.3 3.2 2.4],...
%   'Position', [800 500 720 520],...
%   'WindowStyle','normal',...
%   'DockControls','off'};
% %default_plot_options = {'antipodal'};
% set_LAMPsolar_option('default_plot_options',default_plot_options);
% set_LAMPsolar_option('default_axes_options',default_axes_options);
% set_LAMPsolar_option('default_figure_options',default_figure_options);

FontSize = 26;    %12
LineWidth = 3;  %1

set(0, 'DefaultFigureRenderer', 'zbuffer');

%set(0, 'DefaultFigureRenderer', 'OpenGL');
set(0, 'DefaultTextFontSize', FontSize);
set(0, 'DefaultAxesFontSize', FontSize);
set(0, 'DefaultAxesFontName', 'Verdana');
set(0, 'DefaultAxesLineWidth', LineWidth);
set(0, 'DefaultAxesTickLength', [0.04 0.05]);
set(0, 'DefaultAxesBox', 'on');
set(0, 'DefaultLineLineWidth', LineWidth);
set(0, 'DefaultLineMarkerSize', 10);
set(0, 'DefaultPatchLineWidth', LineWidth);
set(0, 'DefaultFigureColor', [1 1 1]);
set(0, 'DefaultFigurePaperPosition',[2.65 4.3 3.2 2.4]);
set(0, 'DefaultFigurePosition', [400 250 720 520])
% 360x260 pixels on screen keeps same aspect ratio as 3.2x2.4 printed
%set(0, 'DefaultFigurePosition', [800 500 426 320])
set(0, 'DefaultFigureDockControls', 'off')
set(0, 'DefaultFigureColormap', jet);

% try to remember last working directory
if ispref('StartupDirectory','LastWorkingDirectory')
    lwd = getpref('StartupDirectory','LastWorkingDirectory');
    try
        cd(lwd)
    catch errorInfo
        disp('Sorry, but I could not go to your last working directory:')
        disp(errorInfo)
    end;
end;


%% Euler angle convention
% default Euler angle convention

%set_mtex_option('EulerAngleConvention','Bunge');

%% file extensions to be associated with MTEX
% add here your pole figure and EBSD data file extensions 

%set_LAMPsolar_option('polefigure_ext',...
%  {'.exp','.XPa','.cns','.cnv', '.ptx','.pf','.xrdml','.xrd','.epf','.plf','.nja','.gpf','.ras'});
%set_mtex_option('ebsd_ext',...
%  {'.ebsd','.ctf','.ang','.hkl','.tsl'});

%% Default save-mode for generated code snipped (import wizard)
% set to true if generated import-script should be stored on disk by
% default

set_LAMPsolar_option('SaveToFile',false)

%% Path to CIF files
% modify this path if your CIF files are located at a different path
%set_LAMPsolar_option('cif_path',fullfile(LAMPsolar_path,'cif'));

%% Default ColorMap

% LaboTeX color map 
%set_mtex_option('defaultColorMap',LaboTeXColorMap);
 
% white to black color map 
% set_mtex_option('defaultColorMap',grayColorMap);

% jet colormap begin with white
set_LAMPsolar_option('defaultColorMap',WhiteJetColorMap);

% MATLAB default color map
% set_mtex_option('defaultColorMap','default');

%% Default ColorMap for Phase Plots

% set blue red yellow green 
cmap = [0 0 1; 1 0 0; 0 1 0; 1 1 0; 1 0 1; 0 1 1;...
  0.5 1 1; 1 0.5 1; 1 1 0.5;...
  0.5 0.5 1; 0.5 1 0.5; 1 0.5 0.5];
set_LAMPsolar_option('phaseColorMap',cmap);

%% Turn off Grain Selector
% turning off the grain selector allows faster plotting

% set_mtex_option('GrainSelector','off')

%% Workaround for LaTex bug
% comment out the following line if you have problems with displaying LaTex
% symbols

% set_mtex_option('noLaTex');

%% Workaround for NFFT bug
% comment out the following line if MTEX is compiled againsed NFFT 3.1.3 or
% earlier

%set_mtex_option('nfft_bug');

%% architecture 
% this is usefull if the arcitecture is not automatically recognized by
% MTEX

%set_mtex_option('architecture','maci64');

%% default maximum iteration depth for calcODF
% change this value if you want to have another maximum iteration depth to
% be default

set_LAMPsolar_option('ITER_MAX',11);

%% available memory 
% change this value to specify the total amount of installed ram
% on your system in kilobytes

set_LAMPsolar_option('memory',getmem);

%% FFT Accuracy 
% change this value to have more accurate but slower computation when
% involving FFT algorithms
%
set_LAMPsolar_option('FFTAccuracy',1E-2);

%% path for temporary files

set_LAMPsolar_option('tempdir',tempdir);

%% degree character
% MTEX sometimes experences problems when printing the degree character
% reenter the degree character here in this case

degree_char = native2unicode([194 176],'UTF-8');
%degree_char = '??';
set_LAMPsolar_option('degree_char',degree_char);

%% debugging
% comment out to turn on debugging

%set_mtex_option('debug_mode');


%% log file

[~,host] = unix('hostname');
[~,user] = unix('whoami');

if ispc,  user = regexprep(user,{host(1:end-1), filesep},''); end
set_LAMPsolar_option('logfile',[get_LAMPsolar_option('tempdir'),'output_',host(1:end-1),'_',user(1:end-1),'.log']);


%% commands to be executed before the external c program

set_LAMPsolar_option('prefix_cmd','');

% --- setting the priorty -----------------------
% Sometimes it makes sense to run nice in front to lower the priority of
% the calculations

% on linux machines
%set_mtex_option('prefix_cmd','nice -n 19 ');

% on windows machines
%set_mtex_option('prefix_cmd','start /low /b /wait ');
% 'start' runs any programm on windows, the option /low sets the process priorty,
% option /b disables the console window, and the option /wait is required 
% that matlab waits until calculations are done

% --- open in external window -------------------
% Sometimes it is also usefull to have the job running in a seperate console window.

% on linux machines
%set_mtex_option('prefix_cmd','/usr/X11R6/bin/xterm -iconic -e ');
% The specified option -iconic cause xterm to open in the background.
% The option -e is necassary to run a program in the terminal. 

% on windows machines
%set_mtex_option('prefix_cmd','start /wait ');


%% commands to be executed after the external c program
% this might be usefull when redirecting the output or close brackets

set_LAMPsolar_option('postfix_cmd','');

%% compatibility issues
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

%% end user defined global settings
%--------------------------------------------------------------------------
