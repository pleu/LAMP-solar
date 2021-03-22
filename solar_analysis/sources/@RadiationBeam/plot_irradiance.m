function plot_irradiance(rb, xVariable, lineVariable, yVariable)
% dependentVariable can be 'beam', 'diffuse', or 'total'
% independentVariable can be 'latitude', 'day', 'tilt', or 'gamma'
% lineVar can be 'latituded', 'day', 'tilt', or 'gamma'

[varXIndex, varX, xAxisLabel, varXUnits] = rb.get_variable(xVariable);
[y, yM, yAxisLabel] = rb.get_irradiance_variable(yVariable);

[lineIndex, varLine, lineLabel, varLineUnits] = rb.get_variable(lineVariable);


RadiationBeam.check_vars_plot(y, varXIndex, lineIndex);

nDim = length(size(y));
inds = repmat({1},1,nDim);
inds{varXIndex} = 1:length(varX);
numLineVar = length(varLine);
colors = distinguishable_colors(numLineVar+1);

plot(varX, squeeze(y(inds{:})), 'Color', colors(1, :), 'LineStyle', '-');
hold on;
legendLabel = cell(numLineVar+1,1);
legendLabel{1} = 'Incident';

for indLine = 1:numLineVar
  inds{lineIndex} = indLine;
  plot(varX, squeeze(yM(inds{:})), 'Color', colors(indLine+1,:), 'LineStyle', '-');
  hold on;
  legendLabel{indLine+1} = ['Module ', lineLabel, ' = ', num2str(varLine(indLine)), varLineUnits];
end

grid on;

if isempty(varXUnits)
  xlabel(xAxisLabel);
else
  xlabel([xAxisLabel, '(', varXUnits, ')']);
end
ylabel(yAxisLabel);

legend(legendLabel);
legend box off;
