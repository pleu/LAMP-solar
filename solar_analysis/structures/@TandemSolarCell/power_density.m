function [powerDensity, powerDensityGradient] = power_density(V, JSun, F0t)
%POWER_DENSITY
% 
%  V is voltages
%  Jsun is current from sun in Amps/m^2
%  F0t is thermalCurrent in #photons/m^2

J0 = 2*Constants.LightConstants.Q*F0t;  % dark current
x = Constants.LightConstants.Q*V/Constants.LightConstants.k_B*Constants.LightConstants.T_a;
if length(V) > 1
  currentFromAbove = Constants.LightConstants.Q*[0; F0t(1:length(F0t)-1)*exp(x(1:length(x)-1))];
  currentFromBelow = Constants.LightConstants.Q*[F0t(1:length(F0t)-1)*exp(x(2:length(x))); 0];
else
  currentFromAbove = 0;
  currentFromBelow = 0;
end
% Js is current from both sun and emission from neighboring cells
Js = JSun + currentFromAbove + currentFromBelow; 
J1 = Js - J0;

J = J0.*(exp(x)-1)-J1;   % Amps/m^2
powerDensity = V'*J;

powerDensityGradientTerm = (1 + x).*exp(x) - Js./J0;
if length(V) > 1
  powerDensityBelowGradient = [1/2*x(2:length(x)).*exp(x(1:length(x)-1)); 0];
  powerDensityAboveGradient = [1/2*x(1:length(x)-1).*exp(x(2:length(x))).*F0t(1:length(x)-1)./F0t(2:length(x)); 0];
else
  powerDensityBelowGradient = 0;
  powerDensityAboveGradient = 0;
end

powerDensityGradient = powerDensityGradientTerm + powerDensityBelowGradient + powerDensityAboveGradient;



end

