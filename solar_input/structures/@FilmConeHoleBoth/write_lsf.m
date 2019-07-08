function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  obj.Film.write_lsf(filename);
  obj.TopCone.write_lsf(filename);
  obj.BotCone.write_lsf(filename);
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, ['filename = ','"Toprtop' num2str(obj.TopRTop*1e9), 'Toprbot' num2str(obj.TopRBot*1e9), 'TopH' num2str(obj.TopConeZSpan*1e9), 'Botrbot' num2str(obj.BotRBot*1e9), 'Botrbot' num2str(obj.BotRBot*1e9), 'a' num2str(obj.XSpan*1e9) 'T"+num2str(', num2str(obj.ZSpan*1e9), ')' '; \n']);  
  %write_lsf_set_property_line(fid, 'z span', obj.ConeH);

  fclose(fid); 
end
