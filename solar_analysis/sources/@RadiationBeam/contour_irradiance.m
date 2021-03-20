function contour_irradiance(rb, xVariable, yVariable, zVariable)

[varXIndex, varX, xAxisLabel, varXUnits] = rb.get_variable(xVariable);
[varYIndex, varY, yAxisLabel, varYUnits] = rb.get_variable(yVariable);

[z, zM, zAxisLabel] = rb.get_irradiance_variable(zVariable);

RadiationBeamDay.check_vars_plot(z, varXIndex, varYIndex);

[xMat, yMat] = ndgrid(varX, varY); % 

%contourf(xMat, yMat, squeeze(real(zM)));
contourf(xMat, yMat, squeeze(real(zM)), 200, 'LineStyle', 'none');
%contourf(latitudeMatPlot, betaFractionMatPlot, squeeze(real(I_bmA)));
colorbar();
hold on;
[C, h] = contour(xMat, yMat, squeeze(real(zM)), [3 4 5 6 7 8] , 'linecolor', 'k', 'linewidth', 1, 'linestyle', '-')
clabel(C,h, 'FontSize',18,'Color','k', 'LabelSpacing',400)


xlabel([xAxisLabel, '(', varXUnits, ')']);
ylabel([yAxisLabel, '(', varYUnits, ')']);

title(zAxisLabel);


