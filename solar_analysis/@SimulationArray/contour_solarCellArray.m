function contour_solarCellArray(sa, xVarString, yVarString, zVarString, numContourLines, interpolation, plotType)
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

if strcmp(zVarString,'CurrentSC')
  zValues = vertcat(sa.Simulations.CurrentSC)
elseif strcmp(zVarString, 'Efficiency')
  zValues = vertcat(sa.Simulations.Efficiency)
elseif strcmp(zVarString, 'VoltageM')
  zValues = vertcat(sa.Simulations.VoltageM)
elseif strcmp(zVarString, 'CurrentM')
  zValues = vertcat(sa.Simulations.CurrentM)
elseif strcmp(zVarString, 'FF')
  zValues = vertcat(sa.Simulations.FF)
elseif strcmp(zVarString, 'VOC')
  zValues = vertcat(sa.Simulations.VOc)
end

axprop = {'DataAspectRatio',[1 1 8],'View', [0 90]};


[XInd, YInd] = meshgrid(xAxis, yAxis);

if interpolation == 1 % linear interpolation
  [x, y, zValues] = pre_process(x, y, zValues);
  F = scatteredInterpolant(x, y, zValues);
  %F = TriScatteredInterp(x, y, zValues);
  %F = TriScatteredInterp(x, y, zValues, 'nearest');
  ZInd = F(XInd, YInd);
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
  xvector = unique(x);
  yvector = unique(y);
  [X,Y] = ndgrid(xvector,yvector);
  Z = griddata(x, y, zValues, X, Y); 
  [C, h] = contourf(X, Y, Z, numContourLines);
end

if strncmp(plotType, 'cartesian', 4)
  %set(ch, 'edgecolor', 'none');
  shading flat;
  set(h, 'edgecolor', 'none');
  hold on;
  xlabel(xLabel);
  ylabel(yLabel);
%  link_axis(xVarString, yVarString);
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





