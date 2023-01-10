function startup_LAMPsolar
% init LAMP-Solar session
%
% This is the startup file for LAMP-Solar. In general it is not necessary to 
% edit this file. The startup options of LAMP-Solar can be edited in the file
% LAMPsolar_settings.m in this directory.
%
% clc

if  MATLABverLessThan('7.1')
  
  error(['LAMP-Solar cannot be installed because your MATLAB version ',version,...
    ' is outdated and not longer supported by LAMP-Solar. The oldest MATLAB ',...
    'version LAMP-Solar has been tested on is 7.1.']);
end


%%
% path to this function to be considered as the root of the LAMP-Solar
% installation 
local_path = fileparts(mfilename('fullpath'));


%% needs installation ?

install_LAMPsolar(local_path);

%% initialize LAMP-Solar
fprintf('initialize');

%read version from version file
fid = fopen('VERSION','r');
LAMPsolarversion = fgetl(fid);
fclose(fid);
fprintf([' ' LAMPsolarversion '  ']);
p();

%% setup search path 

setLAMPsolarPath(local_path);
p();

%% set path to LAMP-Solar directories

set_LAMPsolar_option('LAMPsolar_path',local_path);
set_LAMPsolar_option('LAMPsolar_data_path',fullfile(local_path,'data'));
set_LAMPsolar_option('LAMPsolar_startup_dir',pwd);
set_LAMPsolar_option('architecture',computer('arch'));
set_LAMPsolar_option('version',LAMPsolarversion);
p();


%% init settings
LAMPsolar_settings;
p();

%% check installation
check_installation;
p();

%% finish
fprintf(repmat('\b',1,length(LAMPsolarversion)+18));

disp([LAMPsolarversion ' toolbox loaded '])
disp(' ');
if isempty(javachk('desktop'))
  disp('Basic tasks:')
  disp('- <a href="matlab:doc LAMP-Solar">Show LAMP-Solar documentation</a>')
  disp(' ');
end

end
%% --------- private functions ----------------------


%% LAMPsolar installation
function install_LAMPsolar(local_path)

% check whether local_path is in search path
cellpath = regexp(path,['(.*?)\' pathsep],'tokens'); 
cellpath = [cellpath{:}]; %cellpath = regexp(path, pathsep,'split');
if any(strcmpi(local_path,cellpath)), return; end

% if not yet installed
disp(' ')
hline('-')
disp('LAMP-Solar is currently not installed.');


% look for older version
if any(strfind(path,'LAMP-Solar'))
  disp('I found an older version of LAMP-Solar');
  disp('I remove it from the current search path!');
  disp('You may need to restart LAMP-Solar!')
  
  inst_dir = cellpath(~cellfun('isempty',strfind(cellpath,'LAMPsolar')));  
  if ~isempty(inst_dir), rmpath(inst_dir{:}); end
end

if  MATLABverLessThan('7.8')
  cd('..'); % leave current directory for some unknown reason
end
addpath(local_path);

disp(' ');
r= input('Do you want to permanently install LAMP-Solar? Y/N [Y]','s');
if isempty(r) || any(strcmpi(r,{'Y',''}))

  % check for old startup.m
  startup_file = fullfile(toolboxdir('local'),'startup.m');
  if exist(startup_file,'file')
    disp(['> There is an old file startup.m in ' toolboxdir('local')]);
    disp('> I''m going to remove it!');
    if ispc
      delete(startup_file);
    else
      sudo(['rm ' startup_file])
    end
  end
  
  disp(' ');
  disp('> Adding LAMP-Solar to the MATLAB search path.');
  if ispc
    install_LAMPsolar_windows;
  else
    install_LAMPsolar_linux;
  end
  
end
  

disp(' ');
disp('LAMP-Solar is now running. However LAMP-Solar documentation might not be functional.');
disp('In order to see the documentation restart MATLAB or click');
disp('start->Desktop Tools->View Source Files->Refresh Start Button');
hline('-')
disp(' ')
if isempty(javachk('jvm'))
  doc; pause(0.1);commandwindow;
end


end

%% windows
function install_LAMPsolar_windows
  
if ~savepath
  disp('> LAMP-Solar permanently added to MATLAB search path.');
else
  disp(' ');
  disp('> Warning: The MATLAB search path could not be saved!');
  disp('> Save the search path manually using the MATLAB menu File -> Set Path.');
end

end

%% Linux
function out = install_LAMPsolar_linux

if ~savepath % try to save the normal way
  disp('> LAMP-Solar permanently added to MATLAB search path.');
else
  
  % if it fails save to tmp dir and move
  savepath([tempdir 'pathdef.m']);

  % move pathdef.m
  out = sudo(['mv ' tempdir '/pathdef.m ' toolboxdir('local')]);

  if ~out
    disp(' ');
    disp('> Warning: The MATLAB search path could not be saved!');
    disp('> In order to complete the installation you have to move the file');
    disp(['   ' tempdir '/pathdef.m']);
    disp('    to');
    disp(['   ' toolboxdir('local')]);
  else
    disp('> MTEX permanently added to MATLAB search path.');
  end
end

end


%% sudo for linux
function out = sudo(c)

disp('> I need root privelegs to perform the following command');
disp(['>   ' c]);
disp('> Please enter the password!');

% is there sudo?
if exist('/usr/bin/sudo','file') 
  
  out = ~system(['sudo ' c]);
  
else % use su
  
  out = ~system(['su -c ' c]);
  
end

end

%% set LAMP-Solar search path
function setLAMPsolarPath(local_path)

% obligatory paths
  %{'solar_input' 'test'},...
%   {'solar_input'},...
%   {'solar_input' 'structures'},...
%   {'solar_input' 'structures' 'truncated cone'}, ...
%   {'solar_input' 'structures' 'truncated cone hole'},...
%   {'solar_input' 'structures' 'rectangle'}, ...
%   {'solar_input' 'structures' 'WoodpileNanowire'},...
%   {'solar_input' 'simulation'}, ...
  %{'solar_input' 'monitors'},...
  %{'solar_input' 'sources'},...
%  {'solar_input' 'examples'},...
%  {'solar_input' 'examples' 'testFilmConeHole'},...
  
toadd = { {''}, ... 
  {'diffraction'},...
  {'solar_input'},...
  {'solar_input', 'structures', 'rectangle'},...
  {'solar_analysis'}, ...
  {'solar_analysis' 'characterization'}, ...
  {'solar_analysis' 'monitors'},...
  {'solar_analysis' 'structures'}, {'solar_analysis' 'sources'},... 
  {'solar_analysis' 'materials'}, {'solar_analysis' 'simulation'},...
  {'solar_analysis' 'transparent_conductors'},...
  {'tools'}, {'tools' 'lsf_tools'}, {'tools' 'file_tools'},{'tools' 'plot_tools'},...
  {'tools' 'statistic_tools'},{'tools' 'math_tools'},...
  {'tools' 'option_tools'},{'tools' 'misc_tools'},...
  {'help' 'classes'},...
  {'grid_analysis'},...
  {'examples'},...
  {'tests' 'xunit'}};

for k=1:length(toadd)
  addpath(fullfile(local_path,toadd{k}{:}),0);
end

% compatibility path
comp = dir(fullfile(local_path,'tools','compatibility','ver*'));

for k=1:length(comp)
  if MATLABverLessThan(comp(k).name(4:end))
    addpath(genpath(fullfile(local_path,'tools','compatibility',comp(k).name)),0);
  end
end

if MATLABverLessThan('7.3'), make_bsx_mex;end

%addpath_recurse(fullfile(local_path,'help','UsersGuide'));

end

%% check MATLAB version 
function result = MATLABverLessThan(verstr)

MATLABver = ver('MATLAB');

toolboxParts = getParts(MATLABver(1).Version);
verParts = getParts(verstr);

result = (sign(toolboxParts - verParts) * [1; .1; .01]) < 0;

end

function parts = getParts(V)
parts = sscanf(V, '%d.%d.%d')';
if length(parts) < 3
  parts(3) = 0; % zero-fills to 3 elements
end
end

function p()
  fprintf('\b.\r');
end


function hline(st)
if nargin < 1, st = '*'; end
disp(repmat(st,1,80));
end
