function plot_versus_energy(sr, monitorType, varargin)
%PLOT_VERSUS_ENERGY Summary of this function goes here
%   Detailed explanation goes here
  %color = ('bgrcmy');
  color = ('bgrcmy');
  for i = 1:size(sr, 2)
    ma = sr.get_monitor(monitorType);
    if nargin > 2
      ma.plot_versus_energy(varargin{i}{:});
    else
      ma.plot_versus_energy({'Color', color(i)});
    end
    hold on;
  end
%  title_or_legend({sr.Name});
  
end

