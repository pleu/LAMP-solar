function [legendH] = plot_transmissionPercent_versus_sheet_resistance(df, varargin)

%PLOT_TRANSMISSIVITY_VERSUS_SHEET_RESISTANCE plots solar transmissivity
%versus sheet resistance for ITO thin film
%   Detailed explanation goes here
if ~isempty(df(1).PlotOptions)
  multiplot({df.SheetResistance},{df.TransmissionIntegratedPercent},df.PlotOptions);
else
  multiplot({df.SheetResistance},{df.TransmissionIntegratedPercent},varargin{:});
end

legendH = title_or_legend({df.LegendString});
ylabel('Transmission (%)');
xlabel('Sheet Resistance');
grid on;
end