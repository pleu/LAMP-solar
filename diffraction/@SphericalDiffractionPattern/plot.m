function [] = plot(obj, figureNumber, varargin)
%PLOT_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here

color = ('bgrcmy');
if nargin == 1
  figureNumber = 1;
end
figure(0 + figureNumber);

for i = 1:size(obj, 2)
  theta = [-obj(i).Theta(numel(obj(i).Theta):-1:2) obj(i).Theta];
  normalizedIntensity = [obj(i).NormalizedIntensity(numel(obj(i).Theta):-1:2) obj(i).NormalizedIntensity];
  plot(theta, normalizedIntensity);
  hold on;
end


xlabel('Theta (degrees)');
ylabel('Normalized Intensity');
axis([-90 90 0 1]);

end

