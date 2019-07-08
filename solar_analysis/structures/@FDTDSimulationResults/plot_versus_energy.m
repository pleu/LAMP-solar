function plot_versus_energy(sr, monitorType, varargin)
%PLOT_VERSUS_ENERGY Summary of this function goes here
%   Detailed explanation goes here
  %color = ('bgrcmy');
  color = ('bgrcmy');
  for i = 1:size(sr, 2)
    if strcmpi(monitorType, 'Reflection')
      %multiplot_add_energy_top_axis({sr.ReflectionResults.Energy}, {{sr.ReflectionResults.Energy})
      %ma = Monitor.empty(numel(sr),0);
      %for i = 1:numel(sr)
      %  ma(i) = sr(i).ReflectionResults;
      %end
      ma = [sr(i).ReflectionResults];
    elseif strcmpi(monitorType, 'Transmission')
      ma = [sr(i).TransmissionResults];
    elseif strcmpi(monitorType, 'Absorption')
      ma = [sr(i).AbsorptionResults];
    end
    if nargin > 2
      ma.plot_versus_energy(varargin{i}{:});
    else
      ma.plot_versus_energy({'Color', color(i)});
    end
    hold on;
  end
  title_or_legend({sr.Name});
  
end

