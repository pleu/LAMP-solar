function [saArray] = create(variableArray, independentVariableType)
% thetaQuery is much finer theta
% frequencyQuery is also much finer frequency
%
% Copyright 2011
% Paul Leu

  if nargin == 1
    independentVariableType = 'frequency';
  end
%   if variableArray.NumVariables ~= 1
%     error('number of variables in variableArray should be 1');
%   end
  simResults = FDTDSimulationResults.empty(variableArray.NumValues, 0);
  for i = 1:variableArray.NumValues
    simResults(i) = FDTDSimulationResults(variableArray.Filenames{i}, independentVariableType);
  end
% This section has been removed due to new BFAST option  
%   if strcmpi(variableArray.Names, 'theta')
%     reflectionResults = [simResults.ReflectionResults];
%     %frequency = vertcat(reflectionResults.Frequency);
%     [frequency] = padcat(reflectionResults.Frequency);
%     % interpolate results onto common set of theta;
%     thetaActual = adjust_theta(variableArray.Values, frequency);
%     [val, ind] = min(abs(variableArray.Values));
%     frequencyQuery = simResults(ind).ReflectionResults.Frequency;
%     %if naragin == 2
%     %thetaQuery = variableArray.Values;
%     %frequencyQuery = ;
%     
%     if nargin > 2
%       [simResultsQuery] = calc_simResultsQuery(simResults, thetaActual, frequencyQuery, thetaQuery);
%       variableArrayQuery = VariableArray(variableArray.Names, variableArray.Units, thetaQuery);
%       saArrayQuery = FDTDSimulationResultsArray(simResultsQuery, variableArrayQuery);
%     end
%     [simResults] = adjust_simResults(simResults, thetaActual, frequencyQuery, variableArray.Values);
% 
% %      
% %    end
%   end
  saArray = FDTDSimulationResultsArray(simResults, variableArray);
  
end

function [simResultsQuery] = calc_simResultsQuery(simResults, thetaActual, frequencyQuery, thetaQuery)
  % will always create simResults
  % create new simResultsQuery 
  % 
  
    simResultsQuery = FDTDSimulationResults.empty(length(thetaQuery), 0);
    for i = 1:length(thetaQuery)
      simResultsQuery(i) = FDTDSimulationResults('');
    end
        
    transmissionResults = [simResults.TransmissionResults];
    reflectionResults = [simResults.ReflectionResults];
    [transmissionResults] = create_query_monitor(transmissionResults, thetaActual, frequencyQuery, thetaQuery);
    [reflectionResults] = create_query_monitor(reflectionResults, thetaActual, frequencyQuery, thetaQuery);
    
    for i = 1:numel(thetaQuery)
      simResultsQuery(i).ReflectionResults = reflectionResults(i);
      simResultsQuery(i).TransmissionResults = transmissionResults(i);
      simResultsQuery(i).AbsorptionResults = simResultsQuery(i).calc_absorption_results;
    end
end

function [simResults] = adjust_simResults(simResults, thetaActual, frequencyQuery, thetaQuery)
  % will always create simResults
  % create new simResultsQuery 
  % 
  transmissionResults = [simResults.TransmissionResults];
  reflectionResults = [simResults.ReflectionResults];
  
  [transmissionResults] = create_query_monitor(transmissionResults, thetaActual, frequencyQuery, thetaQuery);
  [reflectionResults] = create_query_monitor(reflectionResults, thetaActual, frequencyQuery, thetaQuery);
  for i = 1:numel(simResults)
    simResults(i).ReflectionResults = reflectionResults(i);
    simResults(i).TransmissionResults = transmissionResults(i);
    simResults(i).AbsorptionResults = simResults(i).calc_absorption_results;
  end
  
  
%   transmissionResults = [simResults.TransmissionResults];
%   reflectionResults = [simResults.ReflectionResults];
%   
%   [transmissionResults] = adjust_monitor_data(transmissionResults, thetaActual, thetaQuery, frequencyQuery);
%   
%   [reflectionResults] = adjust_monitor_data(reflectionResults, thetaActual, thetaQuery, frequencyQuery);
%   for i = 1:numel(simResults)
%     simResults(i).AbsorptionResults = simResults(i).calc_absorption_results;
%   end
  %sr.AbsorptionResults = sr.calc_absorption_results;
  %[simResults.TransmissionResults] = adjust_monitor_data(transmissionResults, thetaSim, theta);
  
%   if nargout == 2
%     simResultsQuery = FDTDSimulationResults.empty(length(thetaQuery), 0);
%     for i = 1:length(thetaQuery)
%       simResultsQuery(i) = FDTDSimulationResults('');
%     end
%   else
%     
%   end


end

% function [monitorArray] = adjust_monitor_data(monitorArray, thetaActual, thetaQuery, frequencyQuery)
% %QUERY_MONITOR_DATA 
% % queries an array of monitor data taken at thetaActual 
% % and produces new array of monitor data at thetaQuery and frequencyQuery
% 
%   data = vertcat(monitorArray.Data);
%   frequency = vertcat(monitorArray.Frequency);
% 
%   %dataTheta = zeros(numel(theta), size(frequency, 2));
%   
%   dataVec = reshape(data, size(data, 1)*size(data, 2), 1);
%   frequencyVec = reshape(frequency, size(frequency, 1)*size(frequency, 2), 1);
%   thetaActualVec = reshape(thetaActual, size(thetaActual, 1)*size(thetaActual, 2), 1);
%   maxFrequency = max(frequencyQuery);
%   %maxWavelength = max(Photon.convert_frequency_to_wavelength(frequencyVec));
%   
%   figure(1);
%   clf;
%   scatter(frequencyVec, thetaActualVec, [], dataVec, 'o');
%   %scatter(Photon.convert_frequency_to_wavelength(frequencyVec),...
% %    thetaActualVec, [], dataVec, 'o');
% %  hold on;
% %  plot([280 280], [0 90], ':');
%   %
%   
%   %figure(2);
%   %clf;
%   %datavec(1) = 1;
%   %scatter(frequencyVec, thetaActualVec, [], dataVec, 'o');
%   
% %   tri = delaunay(frequencyVec,thetaActualVec);
% %   h = trisurf(tri, frequencyVec, thetaActualVec, dataVec);
% %   shading flat;
% %   view(0, 90);
%   
% %   figure(3);
% %   tri = delaunay(frequencyVec,thetaActualVec);
% %   h = trisurf(tri, frequencyVec,thetaActualVec, dataVec);
% %   
%   %ind = find(thetaActualVec< 55 & thetaActualVec > 45);
%   %scatter(frequencyVec(ind), thetaActualVec(ind), [], dataVec(ind), 'o');
%   
%   %axis([280 1100 0 60])
% 
%   %F = scatteredInterpolant(Photon.convert_frequency_to_wavelength(frequencyVec), thetaActualVec, dataVec, 'linear', 'none');
%   F = scatteredInterpolant(frequencyVec/maxFrequency, thetaActualVec, dataVec, 'linear', 'none');
%   
%   thetaQueryMatrix = repmat(thetaQuery, 1, length(frequencyQuery));
%   frequencyQueryMatrix = repmat(frequencyQuery, length(thetaQuery), 1);
%     
%   thetaQueryVec = reshape(thetaQueryMatrix, size(thetaQueryMatrix, 1)*size(thetaQueryMatrix, 2), 1);
%   frequencyQueryVec = reshape(frequencyQueryMatrix, size(frequencyQueryMatrix, 1)*size(frequencyQueryMatrix, 2), 1);
% 
%   dataQueryVec = F(frequencyQueryVec/maxFrequency, thetaQueryVec);
%   %dataQueryVec = F(Photon.convert_frequency_to_wavelength(frequencyQueryVec), thetaQueryVec);
%   
%   %thetaQueryVec = 25*ones(1, length(frequencyOutput));
%   %frequencyQueryVec = frequencyOutput;
%   %dataQueryVec = F(frequencyQueryVec/maxFrequency, thetaQueryVec);
% %   
% %   figure(3);
% %   clf;
% %   plot(frequencyQueryVec, dataQueryVec);
% %   
%   figure(3);
%   clf;
%   %   scatter(Photon.convert_frequency_to_wavelength(frequencyQueryVec),...
%   %         thetaQueryVec, [], dataQueryVec, 'o');
%   scatter(frequencyQueryVec, thetaQueryVec, [], dataQueryVec, 'o');
%   
%   
%   %axis([8e14 9e14 40 60])
%   
%   %axis([280 400 30 60])
%   %axis([300 320 49 61])
%   
%   dataOutput = reshape(dataQueryVec, length(thetaQuery), length(frequencyQuery));
%   
%   figure(4);
%   clf;
%   contourf(frequencyQuery, thetaQuery, dataOutput, 100);
%   shading flat;
% 
%   %   dataFrequency = reshape(frequencyQuery, length(frequencyOutput), length(theta))';
%   %   dataTheta = reshape(thetaQuery, length(theta), length(frequencyOutput));
%   
%   
%   %for i = 1:size(thetaActual, 2)
%   %     dataVector = data(:, i); % This assumes data is at same frequency
%   %     thetaVector = thetaActual(:, i);
%   %     dataTheta(:, i) = interp1q(thetaVector, dataVector, theta);
%   %   end
%   for i = 1:numel(monitorArray)
%     monitorArray(i).Data = dataOutput(i, :);
%     monitorArray(i).Frequency = frequencyQuery;
%   end
% end

function thetaActual = adjust_theta(thetaArray, frequency)
  %f_simArray = mean(frequency, 2);
  f_simArray = nanmean(frequency, 2);
  thetaActual = real(180/pi*asin(repmat(f_simArray, 1, size(frequency, 2)).*...
    sin(repmat(thetaArray, 1, size(frequency, 2)).*pi/180)./frequency));
end

% function thetaArray = adjust_x_theta(x, monitor, sa)
%   [frequency] =...
%     get_values_and_labels(monitor, sa.VariableArray, 'frequency');
%   %thetaArray = zeros(length(x), size(frequency, 2));
%   f_simArray = mean(frequency, 2);
%   thetaArray = 180/pi*asin(repmat(f_simArray, 1, size(frequency, 2)).*...
%     sin(repmat(x, 1, size(frequency, 2)).*pi/180)./frequency);
% %   for i = 1:length(x)
% %     f_sim = f_simArray(i);
% %     thetaArray(i, :) = 180/pi*asin(f_sim*sin(x(i)*pi/180)./frequency(i, :));
% %   end
% end
