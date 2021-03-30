function contour_irradiance(rb, xVariable, yVariable, zVariable, lines, typePlot,varargin)
axprop = {'DataAspectRatio',[1 1 8],'View', [0 90]};
if nargin == 5
  typePlot = 'Cartesian';
end
[varXIndex, varX, xAxisLabel, varXUnits] = rb.get_variable(xVariable);
[varYIndex, varY, yAxisLabel, varYUnits] = rb.get_variable(yVariable);

[z, zM, zAxisLabel] = rb.get_irradiance_variable(zVariable);

RadiationBeam.check_vars_plot(z, varXIndex, varYIndex);

[xMat, yMat] = ndgrid(varX, varY); % 

%contourf(xMat, yMat, squeeze(real(zM)));

if strncmpi(typePlot, 'Cart', 4)
  if varXIndex < varYIndex
    contourf(xMat, yMat, squeeze(real(zM)), 200, 'LineStyle', 'none');
    hold on;
    [C, h] = contour(xMat, yMat, squeeze(real(zM)), lines , 'linecolor', 'k', 'linewidth', 1, 'linestyle', '-');
  else
    contourf(xMat, yMat, squeeze(real(zM))', 200, 'LineStyle', 'none');
    hold on;
    [C, h] = contour(xMat, yMat, squeeze(real(zM))', lines , 'linecolor', 'k', 'linewidth', 1, 'linestyle', '-');
  end
  %contourf(latitudeMatPlot, betaFractionMatPlot, squeeze(real(I_bmA)));
  colorbar();
  
  
  clabel(C,h, 'FontSize',18,'Color','k', 'LabelSpacing',400)
  
  xlabel([xAxisLabel, '(', varXUnits, ')']);
  ylabel([yAxisLabel, '(', varYUnits, ')']);
  
else
  hAx = axes;
  set(hAx, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
  polarplot3d(squeeze(real(zM)), 'plottype','contourf','ContourLines', 200, 'angularrange', deg2rad([min(varY) max(varY)]), 'radialrange', [min(varX) max(varX)],...
    'ColorData', squeeze(real(zM)), 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', '180', varargin{:});
  %'LineColor', 'none');
  set(gca,axprop{:});
  set(gca, 'Visible', 'off');
end
title(zAxisLabel);





