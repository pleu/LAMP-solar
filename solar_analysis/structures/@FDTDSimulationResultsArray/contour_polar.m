function contour_polar(sa, xVarString, yVarString, monitorType, numContourLines, interpolation)
%function contour(sa, xVarString, yVarString, monitorType, numContourLines)

% CONTOUR
% Plots contour plot of monitor with one axis an independent variable
% and the other axis energy or wavelength
% 
% xVarString or yVarString must be 'Energy' or 'Wavelength'
% monitorType must be 'R', 'T', or 'A'
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

  if nargin < 6
    interpolation = 1; 
  end
  if nargin < 5
    numContourLines = 200;
  end
  
  [monitor] = sa.getMonitor(monitorType);
  [x, xAxis, xLabel] = get_values_and_labels(monitor, sa.VariableArray, xVarString);  
  [y, yAxis, yLabel] = get_values_and_labels(monitor, sa.VariableArray, yVarString);  
   
%   if strcmpi(xVarString, 'theta') 
%     x = adjust_x_theta(x, monitor, sa);
%     x = real(x);
%     interpolation =0;
%   elseif strcmpi(yVarString, 'theta')
%     y = adjust_x_theta(y, monitor, sa);
%     interpolation =0;
%   end
  zValues = vertcat(monitor.Data);

  %set where absorption >= 1 as 1
  index = zValues>1;
  if ~isempty(find(index == 1))
    zValues(index) = 1;
    display('Warning: some values > 1')
  end
  
  index = zValues<0;
  if ~isempty(find(index == 1))
    zValues(index) = 0;
    display('Warning: some values < 0')
  end

  [XInd, YInd] = meshgrid(xAxis, yAxis);
  if strcmpi(yVarString, 'Energy') || strcmpi(yVarString, 'Wavelength')
    zValues = zValues';
  end
    
  if interpolation == 1 % linear interpolation
    [x, y, zValues] = pre_process(x, y, zValues);
    F = scatteredInterpolant(x, y, zValues);
    %F = TriScatteredInterp(x, y, zValues);
    %F = TriScatteredInterp(x, y, zValues, 'nearest');
    ZInd = F(XInd, YInd);        
    %[ch,ch]=contourf(xAxis, yAxis, ZInd, numContourLines);
    contourf(xAxis, yAxis, ZInd, numContourLines, 'LineStyle', 'none')
    %'LineColor', 'none');  
  else % no interpolation
    %numContourLines = 200;
    [r, thetaDeg] = meshgrid(x(1, :), y);
    thetaRad = thetaDeg*pi./180;
    [X, Y] = pol2cart(thetaRad, r);
    
    p = polar([0 2*pi], [min(x(1, :)) max(x(1, :))]);
    delete(p);
    hold on;

    if isvector(x)
      [C, h] = contourf(x, y(1, :)', zValues, numContourLines);
    elseif isvector(y)
%      [C, h] = contour(X, Y, zValues, 10);
      [C, h] = contourf(X, Y, zValues, numContourLines);
      ch = get(h,'child'); 
      alpha(ch,0.2)
      %[C, h] = contourf(x(1, :), y', zValues, numContourLines);
    end
  end
  %set(ch, 'edgecolor', 'none');
  shading flat;
  set(h, 'edgecolor', 'none');
  view(0, -90);
  camroll(90);
  hold on;
  
  h = polarticks(12, p);
  ph=findall(gca,'type','text');
  ps=get(ph,'string');
  ps{strmatch('330', ps)} = '-30';
  ps{strmatch('300', ps)} = '-60';
  ps{strmatch('270', ps)} = '-90';
  set(ph,{'string'},ps);
  
  xlabel(xLabel);
  ylabel(yLabel);
  
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


function [x, xInd, xLabel] = get_values_and_labels(monitor, va, xVarString)
  numPts = 100;
  if strcmpi(xVarString, 'Energy')
    x = vertcat(monitor.Energy);
    xLabel = ('Energy (eV)');
  elseif strcmpi(xVarString, 'Wavelength')
    x = vertcat(monitor.Wavelength);
    xLabel = ('Wavelength (nm)');
  elseif strcmpi(xVarString, 'Frequency')
    x = vertcat(monitor.Frequency);
    xLabel = ('Frequency (Hz)');
  else
    x = va.get_variable_values(xVarString);
    xLabel = va.get_variable_axislabel(xVarString);
  end
  xInd = linspace(min(min(x)), max(max(x)), numPts);  
end  


