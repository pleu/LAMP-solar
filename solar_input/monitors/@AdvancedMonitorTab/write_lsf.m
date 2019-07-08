function [] = write_lsf(obj,filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'spatial interpolation', obj.SpatialInterpolation);
  write_lsf_set_property_line(fid, 'override advanced global monitor settings',...
      obj.Override);
  
  if obj.Override == 1
      write_lsf_set_property_line(fid, 'min sampling per cycle', obj.MinSamplingPercycle);  
  end
  
  fclose(fid);
end