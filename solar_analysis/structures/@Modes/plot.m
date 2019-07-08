function [] = plot(mo, indPlot, factors, varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

if isempty(factors)
  factors = 1;
end

if ismatrix(mo.Wavelength)
  if isempty(indPlot)
    indPlot = 1:size(mo.Wavelength, 1);
  end
  for ind = 1:length(factors)
    dependentVariable = mo.DependentVariable*factors(ind);
    for j = 1:size(indPlot, 2)
      indTEGood = ~isnan(real(mo.Wavelength(indPlot(j), :)));
      optionplot(dependentVariable(indTEGood), real(mo.Wavelength(indPlot(j), indTEGood)), varargin{:});
      hold on;
      %dashline(pitchTECurrent, real(lambdaResonancesTEMetal(indPlotTE(j), indTEGood)), dashSize, gapSize, dashSize,gapSize, 'Color', rgb);
    end
  end
elseif ndims(mo.Wavelength) == 3
  if isempty(indPlot)
    [A,B] = meshgrid(1:size(mo.Wavelength, 1),1:size(mo.Wavelength, 2));
    c=cat(2,A',B');
    indPlot =reshape(c,[],2);
  elseif size(indPlot, 2)~= 2
    error('indPlot must be 2 columns');
  end

  for ind = 1:length(factors)
    dependentVariable = mo.DependentVariable*factors(ind);
    for j = 1:size(indPlot, 1)
      indGood = ~isnan(real(mo.Wavelength(indPlot(j, 1), indPlot(j, 2), :)));
      if ~sum(ind) == 0
        optionplot(dependentVariable(indGood), squeeze(real(mo.Wavelength(indPlot(j, 1), indPlot(j, 2), indGood))), varargin{:});
      end
      hold on;
    end
  end
end


