 function [X, Y, Z] = contour_solarCellArray(sa, xVarString, yVarString, zVarString, numContourLines, interpolation, plotType, varargin)
%function contour(sa, xVarString, yVarString, monitorType, numContourLines)

% CONTOUR
% Plots contour plot of monitor with one axis an independent variable
% and the other axis energy or wavelength
% 
% xVarString or yVarString must be 'Energy' or 'Wavelength'
% monitorType must be 'R', 'T', or 'A'
% interpolation: 0 means no interpolation, 1 means linear interpolation
% if 'theta' is used for variable, then it will form an interpolated grid\\
% plotType is cartesian or polar;
% 
% 
% Example: sa.contour('Wavelength', 'd','Absorption','',0)
% 
%
% See also PLOT_VERSUS_ENERGY
%
%% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
plotTypeOptions = {'cartesian', 'polar'};
if nargin < 7
  plotType = 'cartesian';
else
  check_option(plotTypeOptions, plotType);
end

if nargin < 6
  interpolation = 1;
end
if nargin < 5
  numContourLines = 200;
end

%[monitor] = sa.get_monitor(monitorType);
[x, xAxis, xLabel] = get_values_and_labels(sa.VariableArray, xVarString);
[y, yAxis, yLabel] = get_values_and_labels(sa.VariableArray, yVarString);

if strcmpi(zVarString,'CurrentSC') || strcmpi(zVarString, 'Jsc')
  zValues = abs(vertcat(sa.Simulations.CurrentSC))*Constants.UnitConversions.AmpsPerM2tomAmpsPerCm2;
elseif strcmp(zVarString, 'Efficiency')
  zValues = vertcat(sa.Simulations.Efficiency)*100;
elseif strcmp(zVarString, 'VoltageM')
  zValues = vertcat(sa.Simulations.VoltageM);
elseif strcmp(zVarString, 'CurrentM')
  zValues = vertcat(sa.Simulations.CurrentM);
elseif strcmp(zVarString, 'FF')
  zValues = vertcat(sa.Simulations.FF);
elseif strcmpi(zVarString, 'VOC')
  zValues = vertcat(sa.Simulations.VOC);
elseif strcmpi(zVarString, 'Reflection')
  zValues = vertcat(sa.Reflection);
else
  error('Need valid z value');
end

axprop = {'DataAspectRatio',[1 1 8],'View', [0 90]};


[XInd, YInd] = meshgrid(xAxis, yAxis);

if interpolation == 1 % linear interpolation
  [x, y, zValues] = pre_process(x, y, zValues);
  F = scatteredInterpolant(x, y, zValues);
  %F = TriScatteredInterp(x, y, zValues);
  %F = TriScatteredInterp(x, y, zValues, 'nearest');
  %[ch,ch]=contourf(xAxis, yAxis, ZInd, numContourLines);
  if strncmp(plotType, 'cartesian', 4)
    [C, h] = contourf(xAxis, yAxis, ZInd, numContourLines, 'LineStyle', 'none');
  else
    polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
      'ColorData', log(obj(i).NormalizedIntensity), 'interpmethod', 'nearest', 'polargrid',{9 9});
    %'LineColor', 'none');
  end
else % no interpolation
  %numContourLines = 200;
  if isvector(x) && isvector(y)
    xUnique = unique(x);
    yUnique = unique(y);
    [X,Y] = meshgrid(xUnique,yUnique);
    % need to put in values here
    
%     if length(zValues) == length(yUnique)*length(xUnique)
%       Z = reshape(zValues, [length(yUnique), length(xUnique)]);
%     else
%       F = scatteredInterpolant(x, y, zValues, 'linear', 'none')
%       Z = F(X, Y);
%     end
    [X,Y] = ndgrid(xUnique,yUnique);
    Z = griddata(x, y, zValues, X, Y);
    if strncmp(plotType, 'cartesian', 4)
      [C, h] = contourf(X, Y, Z, numContourLines);
    else
%       polarplot3d(Z, 'plottype','contourf','ContourLines', numContourLines, 'angularrange', deg2rad([yUnique(1) yUnique(end)]), 'radialrange', [xUnique(1) xUnique(end)],...
%         'ColorData', Z, 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw', varargin{:});
      polarplot3d(Z', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', deg2rad([yUnique(1) yUnique(end)]), 'radialrange', [xUnique(1) xUnique(end)],...
        'ColorData', Z', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw', varargin{:});
      %       polarplot3d(zValues(:, ind)', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', y'*pi/180, 'radialrange', [200 1000],...
      %         'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw');
      %
      set(gca,axprop{:});
      xlabel(xLabel);
    end
  elseif isvector(x)
    if strncmp(plotType, 'cartesian', 4)
      [C, h] = contourf(x, y(1, :)', zValues, numContourLines);
    end
  elseif isvector(y)
    if strncmp(plotType, 'cartesian', 4)
      [C, h] = contourf(x(1, :), y', zValues, numContourLines);
    else
      % angularrange must be in radians;
      %       plot(x(1,:), zValues(1, :));
      %       polarplot3d(zValues', 'plottype','surfcn','angularrange',...
      %       y'*pi/180, 'radialrange', x(1,:)',...
      %         'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9, 24});
      %       polarplot3d(zValues', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', y'*pi/180, 'radialrange', x(1,:)',...
      %         'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9 9}, 'polardirection', 'cw')
      
      [sortedX, ind] = sort(x(1,:));
      polarplot3d(zValues(:, ind)', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', [min(y'*pi/180) max(y'*pi/180)], 'radialrange', [min(sortedX) max(sortedX)],...
        'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw', varargin{:});
      %       polarplot3d(zValues(:, ind)', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', y'*pi/180, 'radialrange', [200 1000],...
      %         'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw');
      %
      set(gca,axprop{:});
      xlabel(xLabel);
      %ylabel(xLabel);
      
    end
  end
end
axprop = {'DataAspectRatio',[1 1 8],'View', [0 90]};

if strncmp(plotType, 'cartesian', 4)
  %set(ch, 'edgecolor', 'none');
  shading flat;
  set(h, 'edgecolor', 'none');
  hold on;
  xlabel(xLabel);
  ylabel(yLabel);
  link_axis(xVarString, yVarString);
end



%  title(monitorType);



%position = get(h, 'position');
%position(1) = 0.8;
%set(h, 'position', position);

end

function link_axis(xVarString, yVarString)
wavelengthTicks = [200 300 400 500 600 700 800 900 1000 2000 3000 4000];
wavelengthLabels = {'200', '', '400', '', '600', '', '', '', '1000', '', '', ''};

energyTicks = [0.5 1 2 3 4];
energyLabels = {'0.5', '1', '2', '3', '4'};

if strcmpi(xVarString, 'Energy') || strcmpi(xVarString, 'Wavelength')
  if strcmpi(xVarString, 'Energy')
    add_wavelength_top_axis(wavelengthTicks, wavelengthLabels);
  elseif strcmpi(xVarString, 'Wavelength')
    add_energy_top_axis(energyTicks, energyLabels);
  end
  colorbar('FontSize', 26);
end

if strcmpi(yVarString, 'Energy') || strcmpi(yVarString, 'Wavelength')
  if strcmpi(yVarString, 'Energy')
    add_wavelength_right_axis(wavelengthTicks, wavelengthLabels);
  elseif strcmpi(yVarString, 'Wavelength')
    add_energy_right_axis(energyTicks, energyLabels);
  end
  h = colorbar('FontSize', 26);
  position = get(h, 'Position');
  position(1) = 0.88;
  set(h, 'Position', position);
end
end

function [x, y, zValues] = pre_process(x, y, zValues)
if size(x, 2) == 1
  x = x*ones(1, size(y, 2));
elseif size(y, 2) == 1
  y = y*ones(1, size(x, 2));
end

zValues = reshape(zValues, size(zValues, 1)*size(zValues, 2), 1);
x = reshape(x, size(x, 1)*size(x, 2), 1);
y = reshape(y, size(y, 1)*size(y, 2), 1);
end


function [x, xInd, xLabel] = get_values_and_labels(va, xVarString)
  numPts = 100;
  x = va.get_variable_values(xVarString);
  xLabel = va.get_variable_axislabel(xVarString);
  xInd = linspace(min(min(x)), max(max(x)), numPts);  
end  





