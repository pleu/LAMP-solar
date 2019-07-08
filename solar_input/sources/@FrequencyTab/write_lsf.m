function [] = write_lsf(obj, filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'wavelength start', obj.WavelengthMin);
  write_lsf_set_property_line(fid, 'wavelength stop', obj.WavelengthMax);
  fclose(fid);

end

