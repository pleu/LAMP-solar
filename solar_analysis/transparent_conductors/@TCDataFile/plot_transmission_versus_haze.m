function [] = plot_transmission_versus_haze(df, varargin)
%PLOT_TRANSMISSIVITY_VERSUS_SHEET_RESISTANCE plots solar transmissivity
%versus sheet resistance for ITO thin film
%   Detailed explanation goes here
  multiplot({df.TransmissionIntegratedPercent},{df.Haze},varargin{:});
  title_or_legend({df.LegendString});
  xlabel('Transmission');
  ylabel('Haze');
  grid on;
end

