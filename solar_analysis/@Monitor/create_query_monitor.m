function [monitorQuery] = create_query_monitor(monitorArray, thetaActual, frequencyQuery, thetaQuery)
%QUERY_MONITOR_DATA
% queries an array of monitor data taken at thetaActual
% and produces new array of monitor data at thetaQuery and frequencyQuery

  
  %data = vertcat(monitorArray.Data);
  %frequency = vertcat(monitorArray.Frequency);

  [frequency, tf] = padcat(monitorArray.Frequency);
  data = nan(size(frequency, 1), size(frequency, 2));
  for i = 1:size(frequency, 1)
    data(i, tf(i, :)) = monitorArray(i).Data;
  end
  
  %ind = find(min(abs(thetaActual)))
  %minFrequencyDisplayInd = find(frequency(1, :)==frequencyQuery(1));
  %maxFrequencyDisplayInd = find(frequency(1, :)==max(frequencyQuery));
  numFrequency = length(frequencyQuery);
  
  
  %dataTheta = zeros(numel(theta), size(frequency, 2));
  
%   dataVec = reshape(data, size(data, 1)*size(data, 2), 1);
%   frequencyVec = reshape(frequency, size(frequency, 1)*size(frequency, 2), 1);
%   thetaActualVec = reshape(thetaActual, size(thetaActual, 1)*size(thetaActual, 2), 1);
%   maxFrequency = max(frequencyQuery);
  %maxWavelength = max(Photon.convert_frequency_to_wavelength(frequencyVec));
  
  figure(1);
  clf;
  dataScatter = data;
  dataScatter(dataScatter > 1) = 1;
  dataScatter(dataScatter < 0) = 0;
  indPlot = ~isnan(frequency);
  scatter(frequency(indPlot), thetaActual(indPlot), [], dataScatter(indPlot), 'o');
  %scatter(Photon.convert_frequency_to_wavelength(frequencyVec),...
%    thetaActualVec, [], dataVec, 'o');
%  hold on;
%  plot([280 280], [0 90], ':');
  %
  
  figure(2);
  clf;
  %datavec(1) = 1;
  scatter(Photon.convert_frequency_to_wavelength(frequency(indPlot)), thetaActual(indPlot), [], dataScatter(indPlot), 'o');
  
%   tri = delaunay(frequencyVec,thetaActualVec);
%   h = trisurf(tri, frequencyVec, thetaActualVec, dataVec);
%   shading flat;
%   view(0, 90);
  
%   figure(3);
%   tri = delaunay(frequencyVec,thetaActualVec);
%   h = trisurf(tri, frequencyVec,thetaActualVec, dataVec);
%   
  %ind = find(thetaActualVec< 55 & thetaActualVec > 45);
  %scatter(frequencyVec(ind), thetaActualVec(ind), [], dataVec(ind), 'o');
  
  %axis([280 1100 0 60])

  %F = scatteredInterpolant(Photon.convert_frequency_to_wavelength(frequencyVec), thetaActualVec, dataVec, 'linear', 'none');
  %F = scatteredInterpolant(frequencyVec/maxFrequency, thetaActualVec, dataVec, 'linear', 'none');
  
  %thetaQueryMatrix = repmat(thetaQuery, 1, length(frequencyQuery));
  %frequencyQueryMatrix = repmat(frequencyQuery, length(thetaQuery), 1);
    
  %thetaQueryVec = reshape(thetaQueryMatrix, size(thetaQueryMatrix, 1)*size(thetaQueryMatrix, 2), 1);
  %frequencyQueryVec = reshape(frequencyQueryMatrix, size(frequencyQueryMatrix, 1)*size(frequencyQueryMatrix, 2), 1);

  %dataQueryVec = F(frequencyQueryVec/maxFrequency, thetaQueryVec);
  %dataQueryVec = F(Photon.convert_frequency_to_wavelength(frequencyQueryVec), thetaQueryVec);
  
  %thetaQueryVec = 25*ones(1, length(frequencyOutput));
  %frequencyQueryVec = frequencyOutput;
  %dataQueryVec = F(frequencyQueryVec/maxFrequency, thetaQueryVec);
%   
%   figure(3);
%   clf;
%   plot(frequencyQueryVec, dataQueryVec);
%   
  
  
  %axis([8e14 9e14 40 60])
  
  %axis([280 400 30 60])
  %axis([300 320 49 61])
  
  %dataOutput = reshape(dataQueryVec, length(thetaQuery), length(frequencyQuery));
  
%   figure(3);
%   clf;
%   contourf(frequencyQuery, thetaQuery, dataOutput, 100);
%   shading flat;
%   
%   figure(4);
%   clf;
%   %   scatter(Photon.convert_frequency_to_wavelength(frequencyQueryVec),...
%   %         thetaQueryVec, [], dataQueryVec, 'o');
%   scatter(frequencyQueryVec, thetaQueryVec, [], dataQueryVec, 'o');


  %   dataFrequency = reshape(frequencyQuery, length(frequencyOutput), length(theta))';
  %   dataTheta = reshape(thetaQuery, length(theta), length(frequencyOutput));
  
  dataTheta = zeros(length(thetaQuery), numFrequency);
  for i = 1:length(frequencyQuery)
    dataVector = data(:, i);
    thetaVector = thetaActual(:, i);
    %ind = find(thetaVector == 90);
    ind = find(thetaVector == 90, 1);
    if ~isempty(ind)
      dataVectorInterp = dataVector(1:min(ind));
      thetaVectorInterp = thetaVector(1:min(ind));
    else
      dataVectorInterp = dataVector;
      thetaVectorInterp = thetaVector;
    end
    indNeg = find(thetaVector == -90, 1, 'last');
    if ~isempty(indNeg)
      dataVectorInterp = dataVectorInterp(indNeg:length(dataVectorInterp));
      thetaVectorInterp = thetaVectorInterp(indNeg:length(thetaVectorInterp));
    end
    %dataVectorInterp(min(ind)) = mean(dataVector(ind));
    
    %F = scatteredInterpolant(thetaVector, dataVector, 'linear', 'none');
    dataTheta(:, i) = interp1(thetaVectorInterp, dataVectorInterp, thetaQuery);
  end

  
  %for i = 1:size(thetaActual, 2)
  %     dataVector = data(:, i); % This assumes data is at same frequency
  %     thetaVector = thetaActual(:, i);
  %     dataTheta(:, i) = interp1q(thetaVector, dataVector, theta);
  %   end
  %frequencyQuery = frequency(1,minFrequencyDisplayInd:maxFrequencyDisplayInd);
  monitorQuery = Monitor.empty(length(thetaQuery), 0);
  for i = 1:length(thetaQuery)
    monitorQuery(i).Data = dataTheta(i, :);
    monitorQuery(i).Type = monitorArray(1).Type;
    monitorQuery(i).Frequency = frequencyQuery;
  end
end



