function [] = plot_shockley_queisser_limit(sfa, xVariable, maxX, varargin)
%PLOT_SHOCKLEY_QUEISSER_LIMIT
% 
% Copyright 2011
% Paul Leu

if strcmpi(xVariable, 'energy')
  xVariable = [0 sfa.BandGap sfa.BandGap maxX];
  yVariable = [0 0 1 1];
elseif strcmpi(xVariable, 'wavelength')
  xVariable = [0 Photon.ConvertEnergyToWavelength(sfa.BandGap)...
    Photon.ConvertEnergyToWavelength(sfa.BandGap) maxX]; 
  yVariable = [1 1 0 0];
end
[plotHandle] = optionplot(xVariable, yVariable, varargin{:});

%axesHandle = get(gcf, 'CurrentAxes');
legendHandle = findobj(gcf,'Type','axes','Tag','legend');
legend_append(legendHandle, plotHandle, 'Shockley Queisser Limit');

