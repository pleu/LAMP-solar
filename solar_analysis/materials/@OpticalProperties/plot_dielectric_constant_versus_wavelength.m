function [obj] = plot_dielectric_constant_versus_wavelength(obj)
% READ_OPTICAL_PROPERTIES 

  figure(1);
  multiplot({obj.Wavelength}, {obj.Epsilon1}, 'logarithmic');
  title_or_legend({obj.Filename}); 
  
  xlabel('Wavelength (nm)');
  ylabel('Epsilon1');
  grid on;
  
  figure(2);
  multiplot({obj.Wavelength},{obj.Epsilon2}, 'logarithmic');
  title_or_legend({obj.Filename});
  
  xlabel('Wavelength (nm)');
  ylabel('Epsilon2');
  grid on;
  

end