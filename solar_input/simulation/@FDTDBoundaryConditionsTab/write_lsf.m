function [] = write_lsf(obj,filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'allow symmetry on all boundaries', obj.AllowSymmetryOnAllBoundaries);
  write_lsf_set_property_line(fid, 'x min bc', obj.XMinBc);
  if ~strcmp(obj.XMinBc, {'Periodic','Bloch'})
      write_lsf_set_property_line(fid, 'x max bc', obj.XMaxBc)
  end
  
  write_lsf_set_property_line(fid, 'y min bc', obj.YMinBc);
  if ~strcmp(obj.YMinBc, {'Periodic','Bloch'})
      write_lsf_set_property_line(fid, 'y max bc', obj.YMaxBc)
  end  
  
  write_lsf_set_property_line(fid, 'z min bc', obj.ZMinBc);
  if ~strcmp(obj.ZMinBc, {'Periodic','Bloch'})
      write_lsf_set_property_line(fid, 'z max bc', obj.ZMaxBc)
  end
  
  if strcmp({obj.XMinBc, obj.YMinBc, obj.ZMinBc}, 'Bloch')
      write_lsf_set_property_line(fid, 'set based on source angle', obj.SetBasedOnSourceAngle);
      write_lsf_set_property_line(fid, 'bloch units', obj.BlochUnits);
      if obj.SetBasedOnSourceAngle == 0
          if strcmp(obj.XMinBc, 'Bloch')
              write_lsf_set_property_line(fid, 'kx', obj.KX);
          elseif strcmp(obj.YMinBc, 'Bloch')
              write_lsf_set_property_line(fid, 'ky', obj.KY);
          elseif strcmp(obj.ZMinBc, 'Bloch')
              write_lsf_set_property_line(fid, 'kz', obj.KZ);
          end
      end
  end
  
  write_lsf_set_property_line(fid, 'pml reflection', obj.PMLReflection);
  
  fclose(fid);
end