classdef DataFile < TCDataFile
% This now points to TCDataFile; left in to avoid breaking code
% DataFile class for thin film file from literature
% Read in and save literature data
%
% Copyright 2012
% Paul Leu
methods
  function df = DataFile(filename)
      %df.Filename = filename;
      df = df@TCDataFile(filename);
      %df = TvsRsDataFile(filename);
      % df.Filename = filename;
      %     %df.SheetResistance = 0;
      %     %df.TransmissionIntegrated = 0;
      %[df] = DataFile.ReadFile(filename);
    
  end
  
  function [] = plot_transmissivity_versus_sheet_resistance(df, varargin)
    plot_transmissivity_versus_sheet_resistance@TCDataFile(df, varargin{:});
  end
 
end



methods(Static)
  test()
  
  test2()
  
  function [] = generate_data_file_from_sigma_dc_sigma_op(fom)
    generate_data_file_from_sigma_dc_sigma_op@TCDataFile(fom);
  end
  
  function [df] = add_data_file_and_plotOptions(df, filename, plotOptions)
    sizeDF = length(df);
    df(sizeDF+1) = DataFile(filename);
    df(sizeDF+1).PlotOptions = plotOptions;
  end
  
end

end