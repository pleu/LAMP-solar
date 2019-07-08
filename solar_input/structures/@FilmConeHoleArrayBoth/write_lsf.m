function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  obj.Film.write_lsf(filename);
  obj.TopConeArray.write_lsf(filename);
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, ['for (i = 0:ntop) { \n for (j = 0:ntop) { \n select("cone"); \n copy(i*a/ntop, j*a/ntop); \n'...
  'set("name" , "cone"+num2str(i)+num2str(j)); \n } \n } \n select("cone"); delete; \n']);
  fclose(fid);
  
  obj.BotConeArray.write_lsf(filename);
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, ['for (i = 0:nbot) { \n for (j = 0:nbot) { \n select("cone"); \n copy(i*a/nbot, j*a/nbot); \n'...
  'set("name" , "cone"+num2str(i)+num2str(j)); \n } \n } \n select("cone"); delete; \n']);
  
   fprintf(fid, ['filename = ','"Toprtop' num2str(obj.TopRTop*1e9), 'Toprbot' num2str(obj.TopRBot*1e9), 'TopH' num2str(obj.TopConeZSpan*1e9), 'Topn"+ num2str(ntop)+',...
       '"Botrbot' num2str(obj.BotRBot*1e9), 'Botrbot' num2str(obj.BotRBot*1e9), 'Botn"+ num2str(nbot)+', '"a' num2str(obj.XSpan*1e9) 'T"+num2str(', num2str(obj.ZSpan*1e9), ')' '; \n']);  
  %write_lsf_set_property_line(fid, 'z span', obj.ConeH);
  fclose(fid); 
end
