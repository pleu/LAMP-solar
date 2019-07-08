function [XInd, YInd, ZInd] = contour_haze(obj, xVarString, yVarString, hazeType, varargin)
%function contour(sa, xVarString, yVarString, monitorType, numContourLines)

% CONTOUR
% Plots contour plot of monitor with one axis an independent variable
% and the other axis energy or wavelength
% 
% xVarString or yVarString must be 'Energy' or 'Wavelength'
% hazeType must be 'Angle' or 'Mode'
% interpolation: 0 means no interpolation, 1 means linear interpolation
% if 'theta' is used for variable, then it will form an interpolated grid
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

%numContourLines, interpolation
p.numContourLines = 200;
p.interpolation = 1;

try
  [p,leftovers] = structrecon(pv2struct(varargin{:}),p);
  p.plotprops   = struct2pv(leftovers);
catch ERR
  error('Error parsing varargin list\n??? %s',ERR.message);
end
integratedContour = 0;
if sum(strcmpi(xVarString, {'Energy', 'Frequency', 'Wavelength'})) + sum(strcmpi(xVarString, {'Energy', 'Frequency', 'Wavelength'})) > 2 
  error('Both x or y cannot be energy, frequency or wavelength')
elseif ~(sum(strcmpi(xVarString, {'Energy', 'Frequency', 'Wavelength'})) || sum(strcmpi(xVarString, {'Energy', 'Frequency', 'Wavelength'})))
  integratedContour = 1;
end


[x, xAxis, xLabel] = get_values_and_labels(obj.LightSource, obj.VariableArray, xVarString);
[y, yAxis, yLabel] = get_values_and_labels(obj.LightSource, obj.VariableArray, yVarString);

if integratedContour 
  if strncmp(hazeType, 'A', 1)
    zValues = obj.HazeAngle';
  elseif strncmp(hazeType, 'M', 1)
    zValues = obj.HazeMode';
  elseif strncmp(hazeType, 'T', 1)
    zValues = [obj.Structure.Transparency]';
  elseif strncmp(hazeType, 'N', 1)
    zValues = [obj.NumModes]';
  end
else
  if strncmp(hazeType, 'A', 1)
    zValues = reshape([obj.DiffractionPattern.HazeAngle], size(obj.DiffractionPattern, 1), size(obj.DiffractionPattern, 2));
  elseif strncmp(hazeType, 'M', 1)
    zValues = reshape([obj.DiffractionPattern.HazeMode], size(obj.DiffractionPattern, 1), size(obj.DiffractionPattern, 2));
  elseif strncmp(hazeType, 'N', 1)
    zValues = reshape([obj.DiffractionPattern.NumModes], size(obj.DiffractionPattern, 1), size(obj.DiffractionPattern, 2));
  end
end

if sum(strcmpi(xVarString, {'Energy', 'Frequency', 'Wavelength'})) 
  zValues = zValues';
end

if ~isempty(p.plotprops)
  if sum(strcmpi(p.plotprops{1}, {'Energy', 'Frequency', 'Wavelength'}))
    if strcmpi(p.plotprops{1}, {'Energy'})
      zValues = zValues(:, obj.LightSource.Energy == p.plotprops{2});
    elseif strcmpi(p.plotprops{1}, {'Frequency'})
      zValues = zValues(:, obj.LightSource.Frequency == p.plotprops{2});
    elseif strcmpi(p.plotprops{1}, {'Wavelength'})
      zValues = zValues(:, obj.LightSource.Wavelength == p.plotprops{2});
    end
  else
    [va2, varIndexOut] = obj.VariableArray.get_sub_variable_array(p.plotprops{1}, p.plotprops{2})
  end
  if sum(strcmpi(xVarString, {'Energy', 'Frequency', 'Wavelength'}))
    y = y(varIndexOut);
    zValues = zValues(varIndexOut,:);
  elseif sum(strcmpi(yVarString, {'Energy', 'Frequency', 'Wavelength'}))
    x = x(varIndexOut);
    zValues = zValues(:, varIndexOut);
  end
end


[XInd, YInd] = meshgrid(xAxis, yAxis);
if p.interpolation == 1
  if ~integratedContour
    [x, y, zValues] = pre_process(x, y, zValues);
  end
  F = scatteredInterpolant(x, y, zValues);
  %F = TriScatteredInterp(x, y, zValues);
  %F = TriScatteredInterp(x, y, zValues, 'nearest');
  ZInd = F(XInd, YInd);
  %[ch,ch]=contourf(xAxis, yAxis, ZInd, p.numContourLines);
  [C, h] = contourf(xAxis, yAxis, ZInd, p.numContourLines, 'LineStyle', 'none');
  %'LineColor', 'none');
else % no interpolation
  %numContourLines = 200;
  F = scatteredInterpolant(x, y, zValues, 'linear', 'none');
  [XInd, YInd] = meshgrid(unique(x), unique(y));
  %ZInd = nan(size(XInd));
  ZInd = F(XInd, YInd);
  %ZInd(zValues = 
  
  [C, h] = contourf(unique(x), unique(y), ZInd, p.numContourLines)
  
%   if isvector(x)
%     [C, h] = contourf(x, y(1, :)', zValues, p.numContourLines);
%   elseif isvector(y)
%     [C, h] = contourf(x(1, :), y', zValues, p.numContourLines);
%   end
end
%set(ch, 'edgecolor', 'none');
shading flat;
set(h, 'edgecolor', 'none');
hold on;
xlabel(xLabel);
ylabel(yLabel);

link_axis(xVarString, yVarString);

  
end

%function [x, y, zValues] = select_subset(x, y, zValues, va, plotprops)

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
% two of the values will be same size
% should be wavelength and z
% then just fix x
%if size(x, 2) == 1
if size(x, 2) == 1
  x = x*ones(1, size(y, 2));
  %if size(y, 2) == 1
  y = ones(size(x, 1), 1)*y;
elseif size(x, 1) == 1
  x = ones(size(y, 1), 1)*x;
  %if size(y, 2) == 1
  y = y*ones(1, size(x, 2));
end
  %end
  
  zValues = reshape(zValues, size(zValues, 1)*size(zValues, 2), 1);
  x = reshape(x, size(x, 1)*size(x, 2), 1);
  y = reshape(y, size(y, 1)*size(y, 2), 1);
end



function [x, xInd, xLabel] = get_values_and_labels(ss, va, xVarString)
  numPts = 100;
  if strcmpi(xVarString, 'Energy')
    x = vertcat(ss.Energy);
    xLabel = ('Energy (eV)');
  elseif strcmpi(xVarString, 'Wavelength')
    x = vertcat(ss.Wavelength);
    xLabel = ('Wavelength (nm)');
  elseif strcmpi(xVarString, 'Frequency')
    x = vertcat(ss.Frequency);
    xLabel = ('Frequency (Hz)');
  else
    x = va.get_variable_values(xVarString);
    xLabel = va.get_variable_axislabel(xVarString);
  end
  xInd = linspace(min(min(x)), max(max(x)), numPts);  

end