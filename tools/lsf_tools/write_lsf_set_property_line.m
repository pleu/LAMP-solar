function [] = write_lsf_set_property_line(fid, propertyName, propertyValue)
%WRITE_LSF_SET_PROPERTY_LINE 
%
if ~isempty(propertyValue)
  if iscell(propertyValue)
    fprintf(fid, ['set("', propertyName, '", ''', char(propertyValue), ''');\n']);
  elseif ischar(propertyValue)
    fprintf(fid, ['set("', propertyName, '", ''', propertyValue, ''');\n']);
  elseif isnumeric(propertyValue)
    fprintf(fid, ['set("', propertyName, '", ', num2str(propertyValue), ');\n']);
  end
end
end

