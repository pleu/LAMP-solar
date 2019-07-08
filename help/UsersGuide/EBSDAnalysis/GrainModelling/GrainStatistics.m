%% Grain Statistics
% Access properties of grains to perfom statistics.
%
%% Open in Editor
%
%% Contents
%
%% 
% Grains have several intrinsic properties, which can be used for
% statistical, shape as well as for spatial analysis
%
%%
% Let us first import some EBSD data and perform a regionalisation

loadaachen

[grains ebsd] = segment2d(ebsd,'angle',12.5*degree)

%% Grain-size Analysis
% Since a grain is associated with a <polygon_index.html polygon>, we can determine properties
% of the geometry

ar = area(grains);

%%
% make an expotential bin-size and plot the histogram

bins = exp(-1:0.5:log(max(ar)));

bar( hist(ar,bins) )

%%
% thera are various functions treating the geometry, respectively the shape
% e.g. [[polygon_perimeter.html,perimeter]], [[polygon_equivalentradius.html,equivalentradius]],  
% [[polygon_equivalentperimeter.html,equivalentperimeter]], [[polygon_aspectratio.html,aspectratio]], [[polygon_shapefactor.html,shapefactor]] or concerning the
% convex hull of a grain [[polygon_hullarea.html,hullarea]], 
% [[polygon_paris.html,paris]], [[polygon_deltaarea.html,deltaarea]], so
% there are many ways to analyze its relation to geometry.
%
sf = shapefactor(grains);
as = aspectratio(grains);

scatter(sf, as, ar)


%%
% later on it could be set in relation to its textural properties

%% Spatial Dependencies
% One interessting question would be, wether a polyphase system has
% dependence in the spatial arrangement or not, therefor we can count the
% transitions to a neighbour grain

ph = get(grains,'phase');

[J T p ] = joincount(grains,ph)

%%
% as we see is phase 2 mostly isolated, thus the most transitions ar
% between phase 1 to 1 or phase 1 to 2.
