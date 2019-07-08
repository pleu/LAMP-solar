function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  
  fprintf(fid, ['radius = ', num2str(obj.Radius), '; \n']);  
  fprintf(fid, ['pile_a = ', num2str(obj.Pitch), '; \n']);
  fprintf(fid, ['n_high = ', num2str(obj.NLayer), '; \n']);
  fprintf(fid, 'adduserprop("material",5,"etch"); \n');
  fprintf(fid, 'adduserprop("pile radius",2,radius); \n');
  fprintf(fid, 'adduserprop("pile a",2,pile_a); \n');
  fprintf(fid, 'adduserprop("n high",0,n_high); \n');


%   write_lsf_set_property_line(fid, 'x', obj.X);
%   write_lsf_set_property_line(fid, 'y', obj.Y);
  write_lsf_set_property_line(fid, 'z', 0);
  write_lsf_set_property_line(fid, 'material', obj.Material);

  fclose(fid);
  
end
