function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'simulation type', obj.SimulationType);
  write_lsf_set_property_line(fid, 'override global monitor settings', obj.OverrideGlobalMonitorSettings);
  if obj.OverrideGlobalMonitorSettings
    write_lsf_set_property_line(fid, 'use source limits', obj.UseSourceLimits);
    write_lsf_set_property_line(fid, 'use linear wavelength spacing', obj.UseLinearWavelengthSpacing);
    write_lsf_set_property_line(fid, 'frequency points', obj.FrequencyPoints);
    if ~obj.UseSourceLimits
      write_lsf_set_property_line(fid, 'minimum wavelength', obj.WavelengthMin);
      write_lsf_set_property_line(fid, 'maximum wavelength', obj.WavelengthMax);
    end
  end
  fclose(fid);
  
end
