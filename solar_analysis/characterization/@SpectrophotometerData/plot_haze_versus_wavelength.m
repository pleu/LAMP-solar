function [] = plot_haze_versus_wavelength(sd)

for i = 1:length(sd)
  sd(i).Haze.plot_versus_wavelength;
end

optionplot_add_energy_top_axis(obj.Wavelength,obj.Data,varargin{:});
