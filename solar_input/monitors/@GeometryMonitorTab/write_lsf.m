function [] = write_lsf(obj, filename)
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'monitor type', obj.MonitorType);
  write_lsf_set_property_line(fid, 'x', obj.X);
  write_lsf_set_property_line(fid, 'y', obj.Y);
  write_lsf_set_property_line(fid, 'z', obj.Z);
  if strcmp(obj.MonitorType, 'Linear X')
    write_lsf_set_property_line(fid, 'x span', obj.XSpan);  
    write_lsf_set_property_line(fid, 'down sample X', obj.DownSampleX);
  elseif strcmp(obj.MonitorType, 'Linear Y')
    write_lsf_set_property_line(fid, 'y span', obj.YSpan);  
    write_lsf_set_property_line(fid, 'down sample Y', obj.DownSampleY);
  elseif strcmp(obj.MonitorType, 'Linear Z')
    write_lsf_set_property_line(fid, 'z span', obj.ZSpan);  
    write_lsf_set_property_line(fid, 'down sample Z', obj.DownSampleZ);
  elseif strcmp(obj.MonitorType, '2D X-normal')
    write_lsf_set_property_line(fid, 'y span', obj.YSpan);  
    write_lsf_set_property_line(fid, 'down sample Y', obj.DownSampleY);
    write_lsf_set_property_line(fid, 'z span', obj.ZSpan);  
    write_lsf_set_property_line(fid, 'down sample Z', obj.DownSampleZ);
  elseif strcmp(obj.MonitorType, '2D Y-normal')
    write_lsf_set_property_line(fid, 'x span', obj.XSpan);  
    write_lsf_set_property_line(fid, 'down sample X', obj.DownSampleX);
    write_lsf_set_property_line(fid, 'z span', obj.ZSpan);  
    write_lsf_set_property_line(fid, 'down sample Z', obj.DownSampleZ);
  elseif strcmp(obj.MonitorType, '2D Z-normal')
    write_lsf_set_property_line(fid, 'x span', obj.XSpan);  
    write_lsf_set_property_line(fid, 'down sample X', obj.DownSampleX);
    write_lsf_set_property_line(fid, 'y span', obj.YSpan);  
    write_lsf_set_property_line(fid, 'down sample Y', obj.DownSampleY);
  end
  fclose(fid);
  
end