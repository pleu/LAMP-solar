function contourplot_UE_results_versus_variables(sr, lines, numContourLines, interpolation)
numPts = 100;
if nargin < 3
  numContourLines = 200;
end
if nargin < 4
  interpolation = 1;
end


va = sr.VariableArray;
xAxis = linspace(min(va.Values(:, 1)), max(va.Values(:, 1)), 600);
yAxis = linspace(min(va.Values(:, 2)), max(va.Values(:, 2)), 600);

x = va.get_variable_values(va.Names{1});
y = va.get_variable_values(va.Names{2});

xAxis = linspace(min(min(x)), max(max(x)), numPts); 
yAxis = linspace(min(min(x)), max(max(x)), numPts); 

[XInd, YInd] = meshgrid(xAxis, yAxis);

zValues = sr.UltimateEfficiency;

%ZInd = griddata(x, y, zValues, XInd, YInd, 'linear');

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
   if isvector(x)
     contourf(x, y(1, :)', zValues', numContourLines);
   elseif isvector(y)
     contourf(x(1, :), y', zValues', numContourLines);
   end
 end
  
 shading flat;
 hold on;

zMin=round(min([sr.UltimateEfficiency])*100);
zMax=round(max([sr.UltimateEfficiency])*100);

if nargin == 1
  numLine=zMax-zMin+1;
  lines=linspace(zMin/100,zMax/100,numLine);
end

[c,h] = contour3(XInd, YInd, ZInd, lines,'k');
% cmax = max(max(ZInd));
text_handle = clabel(c, h, 'FontSize', 26)

%clabel(c, h, 'FontSize', 26)
%text_handle = clabel(c, h, 'FontSize', 16);
%set(text_handle, 'FontSize', 16)
colorbar('FontSize', 26);

xlabel(va.VariableAxisLabels{1});
ylabel(va.VariableAxisLabels{2});
[c,h] = contour3(XInd, YInd, ZInd, lines,'k');

for i = 1:length(h)
     zz = get(h(i), 'Zdata');
     set(h(i), 'LineWidth', 2);
%     set(h(i), 'Zdata', (cmax+1)*ones(size(zz)));
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

 