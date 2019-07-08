function [] = write_lsf(obj,filename)

  fid = fopen(create_lsf_filename(filename), 'a+');
  
  write_lsf_set_property_line(fid, 'standard fourier transform', obj.StandardFourierTransform);
  write_lsf_set_property_line(fid, 'partial spectral average', obj.PartialSpectralAverage);
  write_lsf_set_property_line(fid, 'total spectral average', obj.TotalSpectralAverage);
  write_lsf_set_property_line(fid, 'output Ex', obj.OutputEx);
  write_lsf_set_property_line(fid, 'output Ey', obj.OutputEy);
  write_lsf_set_property_line(fid, 'output Ez', obj.OutputEz);
  write_lsf_set_property_line(fid, 'output Hx', obj.OutputHx);
  write_lsf_set_property_line(fid, 'output Hy', obj.OutputHy);
  write_lsf_set_property_line(fid, 'output Hz', obj.OutputHz);
  write_lsf_set_property_line(fid, 'output Px', obj.OutputPx);
  write_lsf_set_property_line(fid, 'output Py', obj.OutputPy);
  write_lsf_set_property_line(fid, 'output Pz', obj.OutputPz);
  write_lsf_set_property_line(fid, 'output power', obj.OutputPower);
  
  fclose(fid);

end