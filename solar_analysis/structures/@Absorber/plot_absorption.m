function plot_absorption(sa, xAxis, varargin)
% xAxis should be 'Energy' or 'Wavelength';
%  color = ('bgrcmy');
  %as = sa.AbsorptionResults;
  %for i = 1:length(sa)
  monitor = Monitor.empty(length(sa), 0);
  for i = 1:length(sa)
    monitor(i) = sa(i).AbsorptionResults;
  end
  
  if strcmpi(xAxis, 'Energy')
    monitor.plot_versus_energy(varargin{:});
  elseif strcmpi(xAxis, 'Wavelength')
    monitor.plot_versus_wavelength(varargin{:});
  end
  
  %title_or_legend({sa.Name});
end




