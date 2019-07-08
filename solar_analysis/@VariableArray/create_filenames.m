function create_filenames(va, filenamePrefix, filenameSuffix)
% CREATE_FILENAMES(va,filenamePrefix, filenameSuffix) 
% creates cell filenames by appending 
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
  va.Filenames = strrep(filenames,' ','');
end




