function [] = plot_t_vs_rs(tcArray, figureNumber, varargin)
%PLOT_T_VS_RS Summary of this function goes here
%   Detailed explanation goes here
  if nargin == 1
    figureNumber = 1;
  end
  figure(figureNumber);
%  clf;
  optionplot([tcArray.SolarCell.SheetResistance],...
    [tcArray.SolarCell.TransmissionIntegrated],...
    'logarithmicX',varargin{:});
  xlabel('Sheet Resistance (\Omega/Square)');
  ylabel('Solar Transmission');
  grid on;
%  axis([0 max(obj.Wavelength) 0 1]);

end

