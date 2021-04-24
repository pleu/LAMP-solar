function [zQ] = extract(rb, zVariable, varNames, varValues)

% z is 4D matrix
% interpolate into 4D matrix
% identify which variables preseent
% which missing?
% 

[z, zM, zAxisLabel, dorA] = rb.get_irradiance_variable(zVariable);

varIndex = cell(length(varNames),1);
var = cell(length(varNames),1);
axisLabel = cell(length(varNames),1);
varUnits = cell(length(varNames),1);

numVarsQ = length(varNames);
for i = 1:numVarsQ
  [varIndex{i}, var{i}, axisLabel{i}, varUnits{i}] = rb.get_variable(varNames{i});
end
if size(varValues, 2)~= numVarsQ
  error('The number of columns must equal the number of query variables');
end
  
nDim = length(size(z));
Xq = zeros(size(varValues, 1), nDim);
%fill out singleton dimensions
varsNotPlot = setdiff(1:nDim, [varIndex{:}]);
for i = 1:length(varsNotPlot)
  if varsNotPlot(i) == 1
    Xq(:, 1) = rb.Latitudes;
  elseif varsNotPlot(i) == 2
    Xq(:, 2) = rb.Days;
  elseif varsNotPlot(i) == 3
    Xq(:, 3) = rb.Betas;
  elseif varsNotPlot(i) == 4
    Xq(:, 4) = rb.Gammas;
  end
end
for i = 1:numVarsQ
  Xq(:, varIndex{i}) = varValues(:, i);
end
    
if dorA == 'd'
  if ~rb.BetaFractionFlag
    [X1, X2, X3, X4] = ndgrid(rb.Latitudes, rb.Betas, rb.Gammas,rb.Delta); %
  else
    [X1, X2, X3, X4] = ndgrid(rb.Latitudes,  rb.BetaFraction, rb.Gammas,rb.Delta); %
  end
else
  if ~rb.BetaFractionFlag
    [X1, X2, X3] = ndgrid(rb.Latitudes, rb.Betas, rb.Gammas); %
  else
    [X1, X2, X3] = ndgrid(rb.Latitudes,  rb.BetaFraction, rb.Gammas); %
  end
end


%interpn(X1, X2, X3, X4, zM, 

if length(varNames) == 2
  [X1, X2] = meshgrid(rb.Betas,rb.Latitudes);
  zQ = interp2(X1, X2,zM, Xq(:,  1), Xq(:, 2));
end









