%% Pole Figure Color Coding
% Explains how to control color coding across multiple plots.
%
%% Open in Editor
%
%% Abstract
% A central issue when interpreting plots is to have a consistent color
% coding among all plots. In MTEX this can be achieved in two ways. If the 
% the minimum and maximum value is known then one can 
% specify the colorrange directly using the options *colorrange* or
% *contourf*, or the command <setcolorrange.html setcolorrange> is used
% which allows to set the color range afterwards. 
%
%% Contents
%
%
%% A sample ODFs and Simulated Pole Figure Data
%
% Let us first define some model ODF_index.html ODFs> to be plotted later
% on.

cs = symmetry('-3m'); ss = symmetry('-1');
odf = fibreODF(Miller(1,1,0),zvector,cs,ss)
pf = simulatePoleFigure(odf,[Miller(1,0,0),Miller(1,1,1)],...
  S2Grid('equispaced','points',500,'antipodal'));

%% Setting a Colormap
%
% By default MTEX uses the default MATLAB colormap *jet*, which varies from
% blue to red for increasing values.

plot(pf)

%%
% However, sometimes more simple colormaps are prefered, like the LaboTeX
% colormap

colormap(LaboTeXColorMap)

%%
% or a gray scale colormap.

colormap(grayColorMap)

%%
% One can set a default colormap adding the following command to
% the configuration file mtex_settings.m

set_mtex_option('defaultColorMap',LaboTeXColorMap);


%% Tight Colorcoding
%
% When <PoleFigure_plot.html plot> is called without option the colorcoding
% of each plot is choosen *tight* to the range of the data independently
% from the other plots, i.e., in each subplot the largest value is assigned
% to the maximum color and the smallest value is assigned to the minimum
% color from the colormap.

close all
plot(pf)


%% Equal Colorcoding
%
% The *tight* colorcoding makes it hard to compare two pole figures. If you
% want to have one colorcoding for all plots within one figure use the
% option *colorrange* to *equal*.

plot(pf,'colorrange','equal')


%% Setting an Explicite Colorrange
%
% If you want to have a unified colorcoding for several figures you can
% set the colorrange directly in the <ODF_plotpdf.html plot command>

close all
plotpdf(odf,[Miller(1,0,0),Miller(1,1,1)],...
  'colorrange',[0 4],'antipodal');
figure
plotpdf(.5*odf+.5*uniformODF(cs,ss),[Miller(1,0,0),Miller(1,1,1)],...
  'colorrange',[0 4],'antipodal');


%% Setting the Contour Levels
%
% In the case of contor plots you can also specify the *contour levels*
% directly

close all
plotpdf(odf,[Miller(1,0,0),Miller(1,1,1)],...
  'contourf',0:1:5,'antipodal')


%% Modifying the Colorrange After Plotting
%
% The color range of the figures can also be adjusted afterwards using the
% command <setcolorrange.html setcolorrange>

setcolorrange([0.38,3.9])


%% 
% The command <setcolorrange.html setcolorrange> also allows to set an
% equal colorcoding to all open figures.

figure(1)
plotpdf(odf,[Miller(1,0,0),Miller(1,1,1)],'antipodal')
figure(2)
plotpdf(.5*odf+.5*uniformODF(cs,ss),[Miller(1,0,0),Miller(1,1,1)],'antipodal');

setcolorrange('equal','all')


%% Logarithmic Plots
%
% Sometimes logarithmic scaled plots are of interest. For this case all
% plots in MTEX understand the option *logarithmic*, e.g.

close all;
plotpdf(odf,[Miller(1,0,0),Miller(1,1,1)],'antipodal','logarithmic')
setcolorrange([0.01 12]);
colorbar

%%
% Finally, lets set back the default colormap.

set_mtex_option('defaultColorMap',WhiteJetColorMap);

