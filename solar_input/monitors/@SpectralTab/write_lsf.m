function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'delta', obj.Delta);
  write_lsf_set_property_line(fid, 'apodization', obj.Apodization);
  
  if ~strcmp(obj.Apodization, 'None')
      write_lsf_set_property_line(fid, 'apodization center', obj.ApodizationCenter);
      write_lsf_set_property_line(fid, 'apodization time width', obj.ApodizationTimeWidth);
  end
  
  fclose(fid);
  
end
