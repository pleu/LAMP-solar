function [] = plot_percent_versus_wavelength(obj, monitorType, varargin)

[monObj] = obj.get_monitor_array(monitorType);

if length(obj) == 1
  optionplot_add_energy_top_axis(monObj.Wavelength,monObj.DataPercent,varargin{:});
else
  multiplot_add_energy_top_axis({monObj.Wavelength},{monObj.DataPercent},varargin{:});
end
%xlabel('Wavelength (nm)');
%ylabel([obj(1).Type,'']);
%  grid on;
%axis([280 max(obj(1).Wavelength) 0 1]);


