function [] = plot_sigmaDCsigmaOP_versus_sheet_resistance(df, varargin)
%PLOT_TRANSMISSIVITY_VERSUS_SHEET_RESISTANCE plots solar transmissivity
%versus sheet resistance for ITO thin film
%   Detailed explanation goes here

if ~isempty(df(1).PlotOptions)
  multiplot({df.SheetResistance},{df.SigmaDCSigmaOP},df.PlotOptions);
else
  multiplot({df.SheetResistance},{df.SigmaDCSigmaOP},varargin{:});
end

  
  title_or_legend({df.LegendString});
  xlabel('Sheet Resistance (\Omega/sq)');
  ylabel('\sigma_{DC}/\sigma_{OP}');
  grid on;
end
