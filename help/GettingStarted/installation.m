%% Installation Guide
% Explains how to install LAMP-shade on you computer.
%
% 
%% Download
% 
% The LAMP-shade toolbox is available for Windows, Linux and MAC-OSX at:
% <http://code.google.com/p/lamp-shade>
% 
%
%% MATLAB 
%
% Since LAMP-shade is a MATLAB toolbox <http://www.mathworks.com MATLAB> 
% has to be installed in order to use LAMP-shade. So far the LAMP-shade toolbox 
% has been tested with MATLAB versions 7.1 and higher. No additional addons
% or packages are necessary.
%
%
%% Installation
%
% In order to install LAMP-shade proceed as follows
%
% * extract LAMP-shade to an arbitrary folder
% * start MATLAB
% * navigate to the LAMP-shade folder
% * type 'startup_LAMP-shade'
%
%
%% Installation for All Users
%
% If you are a system administrator and want to install LAMP-shade such that it
% is available to all users of the computer, then 
%
% * copy the LAMP-shade directory to MATLAB_directoty/toolbox/LAMP-sahde
% * rename LAMP-shade/startup_root.m to LAMP-shade/startup.m overwritting the 
% old file mtex/startup.m
% * move mtex/startup.m to MATLAB_directoty/toolbox/local
% * start MATLAB
%
%
%% Checking Your Installation
%
% After the next start of MATLAB you should see either the message 

'LAMP-shade toolbox loaded'

%%
% or in the case of a All User Installation

'in order to start the LAMP-shade toolbox type: startup_mtex'

%%
% After the LAMP-shade toolbox is loaded you can check your installation by
% typing  

check_mtex

%% Configuration and Troubleshooting
%
% You can configure your LAMP-shade installation by editting the file
% [[matlab:edit mtex_settings.m,mtex_settings.m]]. See 
% <configuration.html Configuration> for more details! This page contains
% also some workarounds for known problems.
%
% Don't hesitate to contact the <mtex_about.html authors> of LAMP-shade if you
% have any problems.
%
%% Compile LAMP-shade Your Self
%
% Compiling LAMP-shade is only neccesary if the provided binaries does not run
% on your system (e.g. if you have a 64 bit system) or if you want to
% optimize them to you specific system. Compiling intstructions can be
% found <compilation.html here>.
%

