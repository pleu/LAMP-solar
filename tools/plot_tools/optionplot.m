function [h] = optionplot(x,y,varargin)
% plot y against x using the options in varargin
%

% new window?
if ~ishold && isappdata(gcf,'axes')
  clf;
end

% logarithmic plot?
if check_option(varargin,'logarithmic')
  h = semilogy(x,y);
elseif check_option(varargin, 'logarithmicX');
  h = semilogx(x, y);
elseif check_option(varargin, 'loglog');
  h = loglog(x, y);
else
  h = plot(x,y);
end
  

% % extract options
fn = fieldnames(get(h));
plotopt = extract_argoption(varargin,fn);
% 
% % set options
if ~isempty(plotopt), set(h,plotopt{:});end

