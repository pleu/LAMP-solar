function [filename] = create_lsf_filename(filename)
%CREATE_LSF_FILE 
  extension_length = 4;
   
  if length(filename) < extension_length ||...
      ~strcmp(filename(end+1-extension_length:end), '.lsf')
    filename = [filename, '.lsf'];
  end

end

