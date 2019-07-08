function [] = write_lsf(obj,filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  
  write_lsf_set_property_line(fid, 'dimension', obj.Dimension);
  write_lsf_set_property_line(fid, 'background index', obj.BackgroundIndex);
  write_lsf_set_property_line(fid, 'simulation time', obj.SimulationTime);

  fclose(fid);
end