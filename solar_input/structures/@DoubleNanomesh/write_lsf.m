function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  obj.TopFilm.write_lsf(filename);
  obj.BottomFilm.write_lsf(filename);
  obj.ActiveFilm.write_lsf(filename);
  obj.Cone1.write_lsf(filename);
  obj.Cone2.write_lsf(filename);
  obj.Cone3.write_lsf(filename);
  obj.Cone4.write_lsf(filename);
  obj.Cone5.write_lsf(filename);
  obj.Cone6.write_lsf(filename);
  obj.Cone7.write_lsf(filename);
  obj.Cone8.write_lsf(filename);
  obj.Cone9.write_lsf(filename);
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  filename = ['"', 'rtop', num2str(obj.RTop*1e9), 'rbot', num2str(obj.RBot*1e9), 'a', num2str(obj.XSpan*1e9), 'Ttop', num2str(obj.TopFilmZSpan*1e9), 'Tbot', num2str(obj.BottomFilmZSpan*1e9), '"'];
  fprintf(fid, ['filename = ',filename, ';\n']);  

%   fprintf(fid, ['filename = ','"rtop' num2str(obj.RTop*1e9), 'rbot', num2str(obj.RBot*1e9),'a', num2str(obj.XSpan*1e9), 'ttop', ...
%       num2str(obj.TopFilmZSpan*1e9),'tbot', num2str(obj.BottomFilmZSpan*1e9) ' '; \n']);  
  %write_lsf_set_property_line(fid, 'z span', obj.ConeH);
  fclose(fid); 
end
