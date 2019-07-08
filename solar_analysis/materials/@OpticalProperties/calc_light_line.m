function [beta] = calc_light_line(op, varargin)
% Calculates the light line beta in 1/nm
beta = op.N.*op.AngularFrequency./Constants.LightConstants.C/Constants.UnitConversions.NMperM; %
