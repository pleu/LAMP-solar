function [hAxes] = link_top_axis_data (TopTickPositions,TopTickLabels,AxisName)
% [newAxis] = LinkTopAxisData (TopTickPositions,TopTickLabels,AxisName)
%
% TopTickPositions specifies the position of the ticks for the top x axis in
% the units of the bottom axis.
%
% TopTickLabels specifies the numerical label for these ticks
%
% AxisName is optional, but if specified it will label the new X axis
%
% newAxis is a handle to the newly created axis
%
% Exampled(Arrhenius plot with temperature as a top scale):
% T=300:-10:100;E=exp(1./T); % Define a dummy set of data
% figure;plot(1000./T,E);xlabel('1000/T / K^{-1}') % Plot the data
% LinkTopAxisData(1000./(300:-50:100),300:-50:100,'T / K'); % Add a top axis
%
% The function will create the new axis behind the current one, so
% clicking gives the original axis rather than the new (dummy) one.
% The properties of the new axis are also linked to the old one, so zooming
% and rescaling should work as advertised.  It will even handle changes to
% linear / log etc.
%
% The (known) bugs are:
%
%  1) On a y log scale where one of the limits is zero the tick marks won't
%  quite align - this is because Matlab reports the lower limit as zero
%  even though it displays a non zero lower limit
%
%  2) Because the two axes are linked, the autoscale checkbox doesn't work
%  for the x and y limits.
%
%  This code is based on the addTopXAxis code by Emmanuel P. Dinnat
%  which can be found on the Matlab file exchange.  The main differences
%  between his program and this one are
%
%  1) This code inputs the top ticks as an array, and they don't have to
%  correspond to the tick positions on the bottom axis
%
%  2) This code hides the new axis behind the first one (making clicking
%  more intuitive)
%
%  3) However... this code is less powerful.
  temp=get(gcf,'Children');
  if size(temp, 1) == 1
    
    position = get(gca, 'Position');
    position(4) = 0.7;
    set(gca, 'Position', position);
    
    oldAxis = gca;
    xLimits = get(gca, 'Xlim');
    yLimits = get(gca, 'Ylim');

    set(oldAxis, 'XAxisLocation', 'bottom');
    set(oldAxis, 'Box', 'off', 'XGrid','off','YGrid','off','Box','off', ...
        'HitTest','off', 'Color', 'none');
    newAxis = axes('Position',get(oldAxis,'Position'));
    %  set(hAxes(2), 'XTick', TopTickPositions, 'Layer', 'top');
    %  set(hAxes(2), 'XTickLabel', TopTickLabels, 'Layer', 'top');
    %   set(hAxes(2), 'Xlim',get(hAxes(1),'Xlim'),'XAxisLocation','top',...
    %     'Color','none','XTick', TopTickPositions,...
    %     'XTickLabel',TopTickLabels,'YTickLabel', get(hAxes(1), 'YTickLabel'),...
    %     'YTick', get(hAxes(1), 'YTick'), 'Layer','top', 'XGrid','off','YGrid','off','Box','off', ...
    %       'HitTest','off');
    
    set(newAxis, 'Xlim',get(oldAxis,'Xlim'),'XAxisLocation','top',...
      'Color','none','XTick', TopTickPositions,...
      'XTickLabel',TopTickLabels,'yaxislocation', 'right', 'YTickLabel', '',...
      'YScale', get(oldAxis, 'YScale'),... 
      'Layer','top', 'XGrid','off','YGrid','off','Box','off', ...
      'HitTest','off');
    
  
%     set(newAxis, 'Xlim',get(oldAxis,'Xlim'),'XAxisLocation','top',...
%       'Color','none','XTick', TopTickPositions,...
%       'XTickLabel',TopTickLabels,'yaxislocation', 'right', 'YTickLabel', '',...
%       'YTick', get(oldAxis, 'YTick'), 'YScale', get(oldAxis, 'YScale'), 'Layer','top', 'XGrid','off','YGrid','off','Box','off', ...
%         'HitTest','off');
  %   set(hAxes(2),'Xlim',get(hAxes(1),'Xlim'),'XAxisLocation','top',...
  %     'Color','none','XTick', TopTickPositions,...
  %     'XTickLabel',TopTickLabels, 'Layer','top', 'XGrid','off','YGrid','off','Box','off', ...
  %       'HitTest','off');  
    xlabel(newAxis,AxisName);

  %   hAxes(3) = axes('Position',get(hAxes(1),'Position'));
  %   set(hAxes(3), 'Xlim',get(hAxes(1),'Xlim'), 'yaxislocation', 'right', ...
  %     'YTickLabel', '',...
  %     'Color', 'none', 'Box', 'off', 'Ylim', get(hAxes(1), 'Ylim'), 'Layer', 'top',...
  %     'XGrid', 'off', 'YGrid', 'off', 'HitTest', 'off')

    linkaxes([newAxis oldAxis],'xy');
    hlink = linkprop([newAxis oldAxis], {'Position','XScale','YScale'});

%    hlink = linkprop([newAxis oldAxis], {'Position','YTick','XScale','YScale','YMinorTick'});
      % And store it on the new axis (to make sure it gets updated, but is
      % also destroyed when the figure is closed / axis is deleted)
    setappdata(newAxis,'Axis_Linkage',hlink);

    % and finally, swap the places of the two axes so that clicking gives the correct
    % behaviour
    temp=get(gcf,'Children');
    tempSwitch = [temp(2); temp(1)];
%     i=temp==newAxis;
%     j=temp==oldAxis;
%     temp(i)=oldAxis;
%     temp(j)=newAxis;
% 
    set(gcf,'Children',tempSwitch);
    axes(oldAxis);
    pause(0.2);   % this seems to fix error with GUI or next function
    set(gcf,'Children',temp);
    
    axis([xLimits yLimits]);
    set(gca, 'YTickMode', 'auto');
    %set(gcf, 'CurrentAxes', temp(2));
  end
    
%  axis(oldAxis);

  

