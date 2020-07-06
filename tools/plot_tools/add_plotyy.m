function [hLine,hAxes] = add_plotyy(x2,y2,Labels,Range,YTick,varargin) %

% currently the right y-axis may have different values, but must be 
% the same as the left y-axis

%axes = get(gcf, 'children);
  axesInd = findobj(gcf,'type','axes');
  
for i = 1:length(axesInd)
  %hAxes(1) = gca;
  
  %set(hAxes(1), 'YAxisLocation', 'left');
  set(axesInd(i), 'box', 'off', 'XGrid','off','YGrid','off', ...
        'HitTest','off', 'Color', 'none', 'Layer', 'top','YAxisLocation', 'left');
  %set(axesInd(i), 'YColor', 'b');
end


%  hAxes(2) = axes('Position',get(hAxes(1),'Position'),'YColor','r');

hAxes = axes('Position',get(axesInd(1),'Position'),'YColor','y');

%yyaxis right

hLine = optionplot(x2, y2, varargin{:});

  uistack(hAxes, 'bottom')

  %hLine = optionplot(x2, y2, varargin{:},'r');
  set(hLine,'color','c')

set(hAxes,'Xlim',get(axesInd(1),'Xlim'),'YAxisLocation','right',...
    'XAxislocation', 'top', 'XTickLabel', '',...
      'XTick', get(hAxes(1), 'XTick'),'Color','none','Layer','top', 'XGrid','off','YGrid','off','Box','off', ...
      'HitTest','off');
%   set(hAxes,'Xlim',get(axesInd(1),'Xlim'),'YAxisLocation','right',...
%     'XAxislocation', 'bottom', 'XTickLabel', '',...
%       'XTick', get(hAxes(1), 'XTick'),'Color','none','Layer','top', 'XGrid','off','YGrid','off','Box','off', ...
%       'HitTest','off');
%     

  %ylabel(hAxes(2),Labels,'Color','r');
  %set(hAxes(2), 'yColor', 'r')

  ylabelh = ylabel(hAxes,Labels,'Color','c');
  % 78.516 17.759 1
%  set(ylabelh, 'Position', get(ylabelh, 'Position') - [0.2 0 0]) 
  set(hAxes, 'yColor', 'c')

  set(hAxes(1), 'XTick', [0 5000]);
  set(hAxes,'Ylim',Range(:));

  
  set(hAxes,'YTick',YTick);
  position = get(hAxes, 'Position');
  %position(3) = 0.75;
  %position(4) = 0.68;
  %set(hAxes, 'Position', position)
 
  for i = 1:length(axesInd)
    set(axesInd(i), 'Position', position)
  end
  colorOpt = get_option(varargin, 'Color');
  if ~isempty(colorOpt)
    ylabel(hAxes,Labels,'Color',colorOpt);
    %ylabel(hAxes,Labels,'Color','k');
    %set(hAxes, 'yColor', 'k');
    %
    set(hAxes, 'yColor', colorOpt);
    set(hLine, 'color', colorOpt);
  end

end

