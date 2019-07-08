function [] = plot_versus_variable(sr, yVariable,...
  yLabel, varargin)
%PLOT_VERSUS_VARIABLE
% Plot y variable versus dependent variable
% 
%% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh  
%sc  xAxisLabel = strcat(sr.VariableStringArray, '(', sr.VariableUnitsArray, ')');
  optionplot(sr.VariableArray.Values, yVariable, varargin);
  grid on;
%  axis([0 max(sr.VariableArray) 0 1]);
  xlabel(sr.VariableArray.VariableAxisLabels);
  ylabel(yLabel);
end


