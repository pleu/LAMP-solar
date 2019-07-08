function [] = write_lsf(obj,filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  % write_lsf_set_property_line(fid, 'current index', obj.CurrentIndex);
 % write_lsf_set_property_line(fid, 'beam profile', obj.BeamProfilePlot);
  fclose(fid);

end

