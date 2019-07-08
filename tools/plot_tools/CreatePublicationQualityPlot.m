function CreatePublicationQualityPlot(figureHandle)
% CREATEPUBLICATIONQUALITYPLOT
defaultPlotOptions = get_LAMPsolar_option('default_plot_options');
defaultAxesOptions = get_LAMPsolar_option('default_axes_options');
defaultFigureOptions = get_LAMPsolar_option('default_figure_options');

axesHandle = get(gcf, 'CurrentAxes')
graphicsHandle = get(axesHandle, 'children');

% modify Legend
legendHandle = findobj(figureHandle,'Tag','legend')
if ~isempty(legendHandle)
  graphicSet(legendHandle, defaultPlotOptions);
end

% modify Figure
graphicSet(gcf, defaultPlotOptions);

% modifyAxes
graphicSet(axesHandle, defaultPlotOptions);

fontSizeOption = extract_argoption(defaultPlotOptions,'FontSize');
set(get(axesHandle,'title'), fontSizeOption{:});
set(get(axesHandle,'xlabel'), fontSizeOption{:});
set(get(axesHandle,'ylabel'), fontSizeOption{:});
set(get(axesHandle,'zlabel'), fontSizeOption{:}); 

% modify Lines
for i = 1:size(graphicsHandle, 1)
  graphicSet(graphicsHandle(i), defaultPlotOptions);
%   if(strcmp(graphicsTypeHandle,'line'))    
%     set(graphicsHandle(i), 'LineWidth', pqp.LineWidth);
%   elseif (strcmp(get(pqp.GraphicsHandle(i),'type'),'patch'))
%     set(GraphicsHandle(i), 'LineWidth', pqp.LineWidth);
%   end
end

function graphicSet(handle, options)

handleFieldNames = fieldnames(get(handle));
handleOptions = extract_argoption(options,handleFieldNames);
set(handle, handleOptions{:});
