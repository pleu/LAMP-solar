function [] = plot_transmission_versus_sheet_resistance(df, varargin)
%PLOT_TRANSMISSIVITY_VERSUS_SHEET_RESISTANCE plots solar transmissivity
%versus sheet resistance for ITO thin film
%   Detailed explanation goes here

if ~isempty(df(1).PlotOptions)
  multiplot({df.SheetResistance},{df.TransmissionIntegrated},df.PlotOptions);
else
  multiplot({df.SheetResistance},{df.TransmissionIntegrated},varargin{:});
end
  title_or_legend({df.LegendString});
  ylabel('Transmission');
  xlabel('Sheet Resisance');
  grid on;
end

