function append_filenames(va, filenamePrefix, filenameSuffix)
% APPEND_FILENAMES(va,filenamePrefix, filenameSuffix) 
% append cell filenames to current list by appending 
% prefix and suffix to all the VariableStrings;
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh

  filenames = char([repmat(filenamePrefix, va.NumValues, 1),...
    char(va.VariableStrings{:})]);
  if nargin == 3
    filenames = char([filenames, repmat(filenameSuffix, va.NumValues, 1)]);
  end    
  
  filenames = cellstr(filenames);
  typeFiles = size(va.Filenames, 2);
  for i = 1:va.NumValues
    va.Filenames(i, typeFiles+1) = strrep(filenames(i),' ','');
  end
end
