function [obj] = write_file(obj, filename)

data = [obj.Frequency; obj.Data];

if exist(filename, 'file') == 2
  delete(filename)
end

%save filename data -ASCII -double -tabs 
dlmwrite(filename, data, 'delimiter', '\t', 'precision',6)
%data