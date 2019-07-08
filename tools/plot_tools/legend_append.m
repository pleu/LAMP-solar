function [] = legend_append(legend_handle, plot_handle, text);

%[LEGH,OBJH,OUTH,OUTM] = legend;
%OBJH = handle;
axesHandle = get(get(legend_handle, 'parent'), 'CurrentAxes');
%axesHandle = get(legend_handle, 'parent');
OUTH = get(axesHandle, 'children');
%OUTH = get(figure_handle, 'CurrentAxes');
OUTM = get(legend_handle, 'String');

% Add object with new handle and new legend string to legend
legend([OUTH; plot_handle], OUTM{:}, text)