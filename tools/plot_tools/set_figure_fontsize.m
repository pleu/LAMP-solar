function [] = set_figure_fontsize(figureHandle, fontSize)

axesHandles = get(figureHandle, 'children');
for i = 1:length(axesHandles)
  set(axesHandles(i), 'FontSize', fontSize)
  h_axLabels = get(axesHandles(i),{'XLabel' 'YLabel'});
  for j = 1:length(h_axLabels)
    set(h_axLabels{j}, 'FontSize', fontSize);
  end
end