%% Configuration
% Explains how to globaly configure MTEX, i.e. how to set a default Euler angle
% convention.
%
%% Global Configuration
%
% The central place of all configuration of the MTEX toolbox is the
% m-file [[matlab:edit mtex_settings.m,mtex_settings.m]]. There the
% following items can be customized
%
% * default Euler angle convention
% * the default plotting style
% * file extension associated with EBSD and pole figure files
% * path to the CIF files
% * the default maximum iteration depth of the function [[PoleFigure_calcODF.html,calcODF]]
% * the amount of available memory
% * the path to the temporary files
% * the name of the log file
%
%
%% The Option System
%
% Many functions provided by MTEX can be customized by options. A option
% is passed to a method as a string parameter followed by a value. For
% example allmost all ploting methods support the option |RESOLUTION|
% followed by a double value specifying the resolution

plotpdf(odf,Miller(1,0,0),'resolution',5*degree,'contour');

%%
% Options that are not followed by a value are called flags. In the above
% example |contour| is a flag that says the plotting routine to plot
% contour lines. Options and flags to a function are allways optional and
% can be passed in any order.
%
