function [XInd, YInd, ZInd] = contour(va, xVarString, yVarString, zValues, numContourLines, interpolationMethod, plotType)
% CONTOUR
% Plots contour plot of zValues 
% 
% returns contour matrix C as seens in contourc
% h is a handle to contour object
% numContourLines is N number of onctour lines or V vector of 
% 
% interpolation method = 0, then 'linear'; if 1, no interpolation
%
plotTypeOptions = {'cartesian', 'polar'};
if nargin < 7
  plotType = 'cartesian';
else
  check_option(plotTypeOptions, plotType);
end

if(va.NumValues ~= length(zValues))
  error('size of variables must be same as zValues');
end
if size(zValues, 2)~=1
  zValues = zValues';
end
if nargin ==4
  numContourLines = 20;
  interpolationMethod = 'linear';
elseif nargin ==5
  interpolationMethod = 'linear';
end

numPts = 200;
x = va.get_variable_values(xVarString);
y = va.get_variable_values(yVarString);


axprop = {'DataAspectRatio',[1 1 8],'View', [0 90]};
xLabel = va.get_variable_axislabel(xVarString);
yLabel = va.get_variable_axislabel(yVarString);

% add 90% contour line
% if strcmpi(interpolationMethod, 'linear')
%   [XInd, YInd] = meshgrid(unique(x), unique(y));
%   F = scatteredInterpolant(x, y, zValues, 'linear');
%   ZInd = F(XInd, YInd);
%   
%   if strncmp(plotType, 'cartesian', 4)
%     [C, h] = contourf(XInd, YInd, ZInd, numContourLines);
%   else
%     polarplot3d(ZInd', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', YInd(:, 1)*pi/180, 'radialrange', XInd(1, :),...
%       'ColorData', ZInd', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw');
%     set(gca,axprop{:});
%     xlabel(xLabel);
%   end
%   
%   %   elseif interpolationMethod == 0
%   %     contourf(x, y, zValues, numContourLines);
% else
xAxis = linspace(min(x), max(x), numPts);
yAxis = linspace(min(y), max(y), numPts);

[XInd, YInd] = meshgrid(xAxis, yAxis);
F = scatteredInterpolant(x, y, zValues, interpolationMethod);
ZInd = F(XInd, YInd);
if strncmp(plotType, 'cartesian', 4)
  [C, h] = contourf(XInd, YInd, ZInd, numContourLines);
else
  polarplot3d(ZInd, 'plottype','contourf','ContourLines', numContourLines, 'angularrange', YInd(:, 1)*pi/180, 'radialrange', XInd(1, :),...
    'ColorData', ZInd, 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw');
end
%end

hold on;
%  contour(XInd, YInd, ZInd,[.9 .9],'w-');

if strncmp(plotType, 'cartesian', 4)
  %  contourf(x, y, zValues, numContourLines);
  shading flat;
  set(h, 'edgecolor', 'none');
  %colormap(jet);
end
hold on;

colorbar('FontSize', 26);

xlabel(xLabel);
ylabel(yLabel);

end

