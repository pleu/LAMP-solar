function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'source shape', obj.SourceShape);
  write_lsf_set_property_line(fid, 'amplitude', obj.Amplitude);
  write_lsf_set_property_line(fid, 'phase', obj.Phase);
  write_lsf_set_property_line(fid, 'injection axis', obj.InjectionAxis);
  write_lsf_set_property_line(fid, 'direction', obj.Direction);
  write_lsf_set_property_line(fid, 'angle theta', obj.AngleTheta);
  write_lsf_set_property_line(fid, 'angle phi', obj.AnglePhi);
  write_lsf_set_property_line(fid, 'polarization angle', obj.PolarizationAngle);
  
  
  fclose(fid);
  
end



