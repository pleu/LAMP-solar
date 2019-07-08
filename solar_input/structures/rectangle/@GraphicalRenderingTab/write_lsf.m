function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'render type', obj.RenderType);
  write_lsf_set_property_line(fid, 'detail', obj.Detail);
  write_lsf_set_property_line(fid, 'override color opacity from material database',...
      obj.OverrideColorOpacityFromMaterialDatabase);
  write_lsf_set_property_line(fid, 'alpha', obj.Alpha);

  fclose(fid);
  
end
