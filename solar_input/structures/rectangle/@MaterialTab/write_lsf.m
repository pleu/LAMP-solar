function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'material', obj.OpticalMaterial);
  
  if strcmp(obj.OpticalMaterial,'Object defined dielectric')
      write_lsf_set_property_line(fid, 'index', obj.Index);
      write_lsf_set_property_line(fid, 'index units', obj.IndexUnits);
  end
  
  write_lsf_set_property_line(fid, 'override mesh order from material database',...
      obj.OverrideMeshOrderFromMaterialDatabase);
  
  if obj.OverrideMeshOrderFromMaterialDatabase == 1
      write_lsf_set_property_line(fid, 'mesh order', obj.MeshOrder);
  end
  
  write_lsf_set_property_line(fid, 'grid attribute name', obj.GridAttributeName);
  
  
  fclose(fid);
  
end

