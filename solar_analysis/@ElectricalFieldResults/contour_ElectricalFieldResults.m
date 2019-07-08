function contour_ElectricalFieldResults(sr, figureNumber)
%contour_ElectricalFieldResults
% Plots E2 and Loss as a function of X and Z
% 
% Copyright 2011
% Baomin Wang
  if nargin == 1
    figureNumber = 0;
  end
  figure(1 + figureNumber);
  clf;
  sr.E2Results.contour_ElectricalField;
  hold on;
  sr.E2Results.plotboundary;


  figure(2 + figureNumber);
  clf;
  sr.PabsResults.contour_ElectricalField;
  hold on;
  sr.PabsResults.plotboundary;
end