function plot_versus_wavelength(sr, monitorType)
%PLOT_VERSUS_WAVELENGTH Summary of this function goes here
%   Detailed explanation goes here
  if strcmpi(monitorType, 'Reflection')
    %multiplot_add_energy_top_axis({sr.ReflectionResults.Energy}, {{sr.ReflectionResults.Energy})
    %ma = Monitor.empty(numel(sr),0);
    %for i = 1:numel(sr)
    %  ma(i) = sr(i).ReflectionResults;
    %end
    ma = [sr.ReflectionResults];  
  elseif strcmpi(monitorType, 'Transmission')
    ma = [sr.TransmissionResults];
  elseif strcmpi(monitorType, 'Absorption')
    ma = [sr.AbsorptionResults];
  end
  ma.plot_versus_wavelength;
  title_or_legend({sr.Name});

end
