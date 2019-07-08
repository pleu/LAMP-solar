classdef TCDataFile
% This now points to TvsRsDataFile; left in to avoid breaking code
% DataFile class for thin film file from literature
% Read in and save literature data
%
% Copyright 2012
% Paul Leu 

  properties
    Filename;
    SheetResistance;
    Haze;
    TransmissionIntegrated;
    LegendString;
    PlotOptions;
  end
  
  properties(Dependent = true)
    SigmaDCSigmaOP;        % figure of merit for transparent conductors;
                           % the higher the better
    TransmissionIntegratedPercent;
  end

  methods
    function df = TCDataFile(filename, property1, value1, property2, value2)
      if nargin > 0
        if nargin == 1          
          df.Filename = filename;
          [x, y, legendString] = TCDataFile.read_file(filename);
          df.SheetResistance = x;
          df.LegendString = legendString;
          df.TransmissionIntegrated = y;
        elseif nargin == 5
          df.Filename = filename;
          [df] = df.assign_value(property1, value1);
          [df] = df.assign_value(property2, value2);
        end
      end
    end
    
    function df = assign_value(df, property, value)
      if strcmpi(property, 'Rs')
        df.SheetResistance = value;
      elseif strcmpi(property, 'haze')
        df.Haze = value;
      elseif strcmpi(property, 'transmission')
        df.TransmissionIntegrated = value;
      else
        error('Property must be Rs, haze, or transmission');
      end
      
    end
  
    
    function sigmaDCSigmaOP = get.SigmaDCSigmaOP(tc)
      sigmaDCSigmaOP = ...
        Constants.LightConstants.Z0./...
        (2*tc.SheetResistance).*sqrt(tc.TransmissionIntegrated)./(1 - sqrt(tc.TransmissionIntegrated));
    end   
    
    function tranmissionIntegratedPercent = get.TransmissionIntegratedPercent(tc)
      tranmissionIntegratedPercent = tc.TransmissionIntegrated*100;
    end   

  end
  
  
  methods(Static) 
   
    
    function [x, y, legendString] = read_file(filename)
      %legendIndex = 2;
      %numHeaderLines = 2;
      %delimiter = ' \t';
      fid = fopen(filename);
      
      iRow = 1;
      textscan(fid,'%s',1,'Delimiter','\n');
      legendString = textscan(fid,'%s',1,'Delimiter','\n');
      legendString = legendString{:};
      legendString = legendString{:};
      % df.LegendString = legendString{:};
      
      while (~feof(fid))
        data(iRow, :) = textscan(fid,'%f %f','CommentStyle','%', 'Delimiter', ' ,\t\n', 'MultipleDelimsAsOne',1);
        iRow = iRow + 1;
      end
      data = cell2mat(data);
      fclose(fid);
      
      x = data(:, 1);
      y = data(:, 2);
      %df = TvsRsDataFile(filename, data(:,1), data(:,2));
    end 
    
    function [df] = read_rs_transmission_file(filename)
      [x, y, legendString] = TCDataFile.read_file(filename);
      df = TCDataFile(filename, 'Rs', x, 'Transmission', y);
      df.LegendString = legendString;
      df.Filename = filename;
    end
    
    
    function [df] = read_haze_transmission_file(filename)
      [x, y, legendString] = TCDataFile.read_file(filename);
      df = TCDataFile(filename, 'Haze', x, 'Transmission', y);
      df.LegendString = legendString;   
      df.Filename = filename;
    end
    
    
    test()
    
    test2()
    
    test3()
    
    test4()
    
    generate_data_file_from_sigma_dc_sigma_op(fom);
  end
    
end


