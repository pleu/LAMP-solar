function [] = write_lsf(obj,filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'force symmetric x mesh', obj.ForceSymmetricXMesh);
  write_lsf_set_property_line(fid, 'force symmetric y mesh', obj.ForceSymmetricYMesh);
  write_lsf_set_property_line(fid, 'force symmetric z mesh', obj.ForceSymmetricZMesh);
  write_lsf_set_property_line(fid, 'override simulation bandwidth for mesh generation',...
      obj.OverrideSimulationBandwidthForMeshGeneration);
  
  if obj.OverrideSimulationBandwidthForMeshGeneration == 1
      write_lsf_set_property_line(fid, 'mesh min', obj.WavelengthMin);  
      write_lsf_set_property_line(fid, 'mesh max', obj.WavelengthMax);
  end
  
  write_lsf_set_property_line(fid, 'snap pec to yee cell boundary', obj.SnapPertoYeeCellBoundary);
  write_lsf_set_property_line(fid, 'always use complex fields', obj.AlwaysUseComplexField);
  write_lsf_set_property_line(fid, 'use early shutoff', obj.UseEarlyShutoff);
  
  if obj.UseEarlyShutoff == 1
      write_lsf_set_property_line(fid, 'auto shutoff min', obj.AutoShutoff);
  end
  
  write_lsf_set_property_line(fid, 'use divergence checking', obj.UseDivergenceChecking);
  
  if obj.UseDivergenceChecking == 1
      write_lsf_set_property_line(fid, 'auto shutoff max', obj.AutoShutoffMax);
  end
  
  write_lsf_set_property_line(fid, 'down sample time', obj.DownSmapleTime);
  write_lsf_set_property_line(fid, 'pml kappa', obj.PmlKappa);
  write_lsf_set_property_line(fid, 'pml sigma', obj.PmlSigma);
  write_lsf_set_property_line(fid, 'minimum pml layers', obj.MinimumPmlLayers);
  write_lsf_set_property_line(fid, 'maximum pml layers', obj.MaximumPmlLayers);
  write_lsf_set_property_line(fid, 'pml polynomial', obj.PmlPolynomial);
  write_lsf_set_property_line(fid, 'type of pml', obj.TypeofPml);
  write_lsf_set_property_line(fid, 'max source time signal length',...
      obj.MaxSourceTimeSignalLength);
  write_lsf_set_property_line(fid, 'Set process grid', obj.SetProcessGrid);
  
  if obj.SetProcessGrid == 1
      write_lsf_set_property_line(fid, 'nx', obj.Nx);
      write_lsf_set_property_line(fid, 'ny', obj.Ny);
      write_lsf_set_property_line(fid, 'nz', obj.Nz);
  end
  
  fclose(fid);
end