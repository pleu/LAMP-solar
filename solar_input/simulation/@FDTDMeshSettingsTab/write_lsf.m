function [] = write_lsf(obj, filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  mesh = obj.MeshSettings;
  meshtype = obj.MeshType;
  if strcmp(meshtype, 'auto non-uniform')
      write_lsf_set_property_line(fid, 'mesh type', meshtype);
      write_lsf_set_property_line(fid, 'mesh accuracy', mesh.MeshAccuracy);
      write_lsf_set_property_line(fid, 'mesh refinement', mesh.MeshRefinement);
      if strcmp(mesh.MeshRefinement, 'dielectric volume average')
          write_lsf_set_property_line(fid, 'meshing refinement', mesh.MeshingRefinement);
      end
      write_lsf_set_property_line(fid, 'dt stability factor', mesh.DtStabilityFactor);
      write_lsf_set_property_line(fid, 'min mesh step', mesh.MinMeshStep);  
      
  elseif strcmp(meshtype, 'custom non-uniform')
      write_lsf_set_property_line(fid,'mesh type', meshtype);
      write_lsf_set_property_line(fid,'define x mesh by', mesh.DefineXMesh);          
      write_lsf_set_property_line(fid,'define y mesh by', mesh.DefineYMesh);
      write_lsf_set_property_line(fid,'define z mesh by', mesh.DefineZMesh);      
      
      if strcmp(mesh.DefineXMesh, 'maximum mesh step') ||...
              strcmp(mesh.DefineXMesh, 'max mesh stop and mesh cells per wavelength')
          write_lsf_set_property_line(fid, 'dx', mesh.Dx);
      elseif strcmp(mesh.DefineXMesh, 'number of mesh cells') 
          write_lsf_set_property_line(fid, 'mesh cells x', mesh.MeshCellsX);
      end
      
      if strcmp(mesh.DefineYMesh, 'maximum mesh step') ||...
              strcmp(mesh.DefineYMesh, 'max mesh stop and mesh cells per wavelength')
          write_lsf_set_property_line(fid, 'dy', mesh.Dy);
      elseif strcmp(mesh.DefineYMesh, 'number of mesh cells') 
          write_lsf_set_property_line(fid, 'mesh cells y', mesh.MeshCellsY);
      end      

      if strcmp(mesh.DefineZMesh, 'maximum mesh step') ||...
              strcmp(mesh.DefineZMesh, 'max mesh stop and mesh cells per wavelength')
          write_lsf_set_property_line(fid, 'dz', mesh.Dz);
      elseif strcmp(mesh.DefineZMesh, 'number of mesh cells') 
          write_lsf_set_property_line(fid, 'mesh cells z', mesh.MeshCellsZ);
      end  
      
      if ~strcmp(mesh.DefineXMesh, 'number of mesh cells')
          write_lsf_set_property_line(fid,'allow grading x', mesh.AllowGradingX);
      end
      if ~strcmp(mesh.DefineYMesh, 'number of mesh cells')      
          write_lsf_set_property_line(fid,'allow grading y', mesh.AllowGradingY);
      end
      if ~strcmp(mesh.DefineZMesh, 'number of mesh cells')      
          write_lsf_set_property_line(fid,'allow grading z', mesh.AllowGradingZ);
      end
          write_lsf_set_property_line(fid,'grading factor', mesh.GradingFactor);
          write_lsf_set_property_line(fid, 'mesh refinement', mesh.MeshRefinement);
      if strcmp(mesh.MeshRefinement, 'dielectric volume average')
          write_lsf_set_property_line(fid, 'meshing refinement', mesh.MeshingRefinement);
      end
      
      write_lsf_set_property_line(fid, 'mesh cells per wavelength', mesh.MeshCellsPerWavelength);
      write_lsf_set_property_line(fid, 'dt stability factor', mesh.DtStabilityFactor);
      write_lsf_set_property_line(fid, 'min mesh step', mesh.MinMeshStep);
      
  elseif strcmp(meshtype, 'uniform')
      write_lsf_set_property_line(fid,'mesh type', meshtype);
      if strcmp(mesh.DefineXMesh, 'maximum mesh step')
      write_lsf_set_property_line(fid,'define x mesh by', mesh.DefineXMesh);
      write_lsf_set_property_line(fid, 'dx', mesh.Dx);
      elseif strcmp(mesh.DefineXMesh, 'number of mesh cells')
          write_lsf_set_property_line(fid,'define x mesh by', mesh.DefineXMesh);
          write_lsf_set_property_line(fid, 'mesh cells x', mesh.MeshCellsX);
      end
      if strcmp(mesh.DefineYMesh, 'maximum mesh step')
      write_lsf_set_property_line(fid,'define y mesh by', mesh.DefineYMesh);
      write_lsf_set_property_line(fid, 'dy', mesh.Dy);
      elseif strcmp(mesh.DefineYMesh, 'number of mesh cells')
          write_lsf_set_property_line(fid,'define y mesh by', mesh.DefineYMesh);
          write_lsf_set_property_line(fid, 'mesh cells y', mesh.MeshCellsY);
      end
      if strcmp(mesh.DefineZMesh, 'maximum mesh step')
      write_lsf_set_property_line(fid,'define z mesh by', mesh.DefineZMesh);
      write_lsf_set_property_line(fid, 'dz', mesh.Dz);
      elseif strcmp(mesh.DefineZMesh, 'number of mesh cells')
          write_lsf_set_property_line(fid,'define z mesh by', mesh.DefineZMesh);
          write_lsf_set_property_line(fid, 'mesh cells z', mesh.MeshCellsZ);
      end
                  
      write_lsf_set_property_line(fid, 'mesh refinement', mesh.MeshRefinement);
      if strcmp(mesh.MeshRefinement, 'dielectric volume average')
          write_lsf_set_property_line(fid, 'meshing refinement', mesh.MeshingRefinement);
      end
      write_lsf_set_property_line(fid, 'dt stability factor', mesh.DtStabilityFactor);
      write_lsf_set_property_line(fid, 'min mesh step', mesh.MinMeshStep);      
  end
  fclose(fid);

end

