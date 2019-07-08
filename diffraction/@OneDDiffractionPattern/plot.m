function [] = plot(obj, figureNumber, varargin)
%PLOT_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here

%color = ('bgrcmy');
colors = distinguishable_colors(size(obj, 1)*size(obj, 2));
linestyles = {'-.', ':', '--'};
if nargin == 1
  figureNumber = 1;
end
figure(figureNumber);
clf;
for j = 1:size(obj, 2)
  for i = 1:size(obj, 1)
    %theta = [-obj(i).Theta(numel(obj(i).Theta):-1:2) obj(i).Theta];
    %normalizedIntensity = [obj(i).NormalizedIntensity(numel(obj(i).Theta):-1:2) obj(i).NormalizedIntensity];
    %plot(theta, normalizedIntensity, color(i));
    plot(obj(i, j).Theta, obj(i, j).NormalizedIntensity,...
      'Color', colors(i+(j-1)*size(obj,1), :), 'LineStyle', linestyles{j});
    hold on;
  end
end


xlabel('Theta (degrees)');
ylabel('Normalized Intensity');
axis([-90 90 0 1]);

end

