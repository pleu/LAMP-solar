function [lambdaResonances] = plot_modes(ns, TEorTM, varargin)
%PLOT_MODES Summary of this function goes here
%   Detailed explanation goes here
lambdaResonances = ns.calculate_modes(TEorTM);

for j = 1:size(lambdaResonances, 1)
  for k = 1:size(lambdaResonances, 2)
    ind = ~isnan(real(lambdaResonances(j, k, :)));
    if ~sum(ind) == 0
      optionplot(ns.Diameter(ind), squeeze(real(lambdaResonances(j, k, ind))), varargin{:});
    end
    hold on;
  end
end

