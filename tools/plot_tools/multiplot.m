function multiplot(xdata,ydata,varargin)
%MULTIPLOT
% plot ydata against xdata using the options in varargin
%
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
%color = ('bgrcmyk');

numDatasets = length(xdata);
colors = distinguishable_colors(numDatasets);


if ~isempty(varargin)
  if size(varargin, 1) ~= size(xdata,1)
    vararginOrig = varargin;
    vararginOut = cell(size(xdata, 2), length(varargin));
    for i = 1:size(xdata, 2)
      vararginOut{i} = vararginOrig{:};
    end
    varargin = vararginOut;
  end
end

if numDatasets == 1
  if isempty(varargin) || isempty(get_option(varargin{:}, 'Color'))
    options = {'Color', 'b', varargin{:}};
    optionplot(xdata{1}, ydata{1}, options{:});
  else
    optionplot(xdata{1}, ydata{1},varargin{:}{:});
  end
else
  for ind = 1:numDatasets 
    if isempty(varargin) || isempty(get_option(varargin{1}, 'Color')) || isempty(get_option(varargin{ind}, 'Color'))
      options = {varargin{:}, 'Color', colors(ind,:)};
      optionplot(xdata{ind}, ydata{ind}, options{:});
      hold on;
    else
      if size(varargin, 2) == 1
        optionplot(xdata{ind}, ydata{ind},varargin{:}{:});
      else
        optionplot(xdata{ind}, ydata{ind},varargin{ind}{:});
      end
      hold on;
    end
  end
end
  
%   if isempty(varagin) || isempty(get_option(varargin{:}, 'Color'))
%     optionplot(xdata{1}, ydata{1},varargin{:});
%   end
% else
%   
% end
% 
%     color = ('bgrcmy');
%   numDatasets = length(xdata);
%   for ind = 1:numDatasets
%     options = {['Color', color(ind), varargin]};
%     optionplot(xdata{ind}, ydata{ind}, options{:});
%     hold on;
%   %mysubplot(ind);
%   end
% else
%   numDatasets = length(xdata);
%   if numDatasets == 1
%     optionplot(xdata{1}, ydata{1},varargin{:});
%   else
%     for ind = 1:numDatasets
%       if size(varargin, 2) == 1
%         optionplot(xdata{ind}, ydata{ind},varargin{:});
%       else
%         optionplot(xdata{ind}, ydata{ind},varargin{ind}{:});
%       end
%       hold on;
%     %mysubplot(ind);
%     end
%   end
% end
