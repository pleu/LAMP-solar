function [] = generate_data_file_from_sigma_dc_sigma_op(fom)
transmission = linspace(0.01, 0.999, 300);
Rs = ...
  Constants.LightConstants.Z0./...
  (2*fom).*sqrt(transmission)./(1 - sqrt(transmission));

fid = fopen(['FOM', num2str(fom), '.txt'], 'w');
fprintf(fid, '# Figure of merit file, FOM = %f\n', fom);
fprintf(fid, 'generated from figure of merit \n');
data = [Rs; transmission];

fprintf(fid, '%f %f\n', data);

fclose(fid);


end

