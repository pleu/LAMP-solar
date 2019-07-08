classdef Simulation1D
% SIMULATION1D class for multilayered thin film simulation
% 
% See also ThinFilmLayer, ThinFilmLayerArray
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh 
  
  properties
    ThinFilmLayers;
  end
  
  properties (Dependent = true)
    NumLayers;
  end
  
  methods
    function tfArray = ThinFilmLayerArray(materials, thicknesses)
      if nargin > 0
        numLayers = size(materials);
        tfArray.ThinFilmLayers = ThinFilmLayer.empty(numLayers, 0);
        for i = 1:size(materials)
          tfArray.ThinFilmLayers(i) = ...
            ThinFilmLayer(materials(i), thicknesses(i));
        end
      end
    end
  
    function SimulateStructure(tfArray)
      
      Theta;          % Ray angle in each layer
      K;              % wavevector in each layer
      
      
      
    end
        
    function numLayers = get.NumLayers(tfArray)
      numLayers = size(tfArray.ThinFilmLayers, 2);
    end
    
    function [coeffS, coeffP] = CalculateMMatrixFast(structureInfo, lightInfo, lambdaIndex)

      coeffS = zeros(2, structureInfo.numLayersTotal);
      coeffS(:, structureInfo.numLayersTotal) = [1; 0]; % no reflection from last layer
      coeffP = zeros(2, structureInfo.numLayersTotal);
      coeffP(:, structureInfo.numLayersTotal) = [1; 0]; % no reflection from last layer

      index = structureInfo.numLayersTotal;
      Ds = [1 1;
          structureInfo.nTable(lambdaIndex, index)*cos(lightInfo.thetaMat(lambdaIndex, index)) -structureInfo.nTable(lambdaIndex, index)*cos(lightInfo.thetaMat(lambdaIndex, index))];
      Dp = [cos(lightInfo.thetaMat(lambdaIndex, index)) cos(lightInfo.thetaMat(lambdaIndex, index));
              structureInfo.nTable(lambdaIndex, index) -structureInfo.nTable(lambdaIndex, index)];
      MsTemp = eye(2);
      MpTemp = eye(2);

      phi = lightInfo.kMat(lambdaIndex, :).*structureInfo.dm;
      for index = structureInfo.numLayersTotal-1:-1:2
          DsPrev = Ds;
          DpPrev = Dp;
          Ds = [1 1;
              structureInfo.nTable(lambdaIndex, index)*cos(lightInfo.thetaMat(lambdaIndex, index)) -structureInfo.nTable(lambdaIndex, index)*cos(lightInfo.thetaMat(lambdaIndex, index))];
          Dp = [cos(lightInfo.thetaMat(lambdaIndex, index)) cos(lightInfo.thetaMat(lambdaIndex, index));
              structureInfo.nTable(lambdaIndex, index) -structureInfo.nTable(lambdaIndex, index)];

          % phi(index) = lightInfo.kMat(lambdaIndex, index)*structureInfo.dm(index);
          P = [exp(i*phi(index)) 0;
              0 exp(-i*phi(index))];

          MsTemp = P*inv(Ds)*DsPrev*MsTemp;
          MpTemp = P*inv(Dp)*DpPrev*MpTemp;
          coeffS(:, index) = MsTemp*coeffS(:, structureInfo.numLayersTotal);
          coeffP(:, index) = MpTemp*coeffP(:, structureInfo.numLayersTotal);
      %    coeffs = MsTemp*coeffs(index, :);
      end

      index = 1;
      DsPrev = Ds;
      DpPrev = Dp;
      Ds = [1 1;
          structureInfo.nTable(lambdaIndex, index)*cos(lightInfo.thetaMat(lambdaIndex, index)) -structureInfo.nTable(lambdaIndex, index)*cos(lightInfo.thetaMat(lambdaIndex, index))];
      Dp = [cos(lightInfo.thetaMat(lambdaIndex, index)) cos(lightInfo.thetaMat(lambdaIndex, index));
              structureInfo.nTable(lambdaIndex, index) -structureInfo.nTable(lambdaIndex, index)];

      MsTemp = inv(Ds)*DsPrev*MsTemp;
      MpTemp = inv(Dp)*DpPrev*MpTemp;

      coeffS(:, index) = MsTemp*coeffS(:, structureInfo.numLayersTotal);
      coeffP(:, index) = MpTemp*coeffP(:, structureInfo.numLayersTotal);
    end
    
  
end
