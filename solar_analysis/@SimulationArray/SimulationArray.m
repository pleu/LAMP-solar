classdef SimulationArray
  %SIMULATIONARRAY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    VariableArray;
    Simulations;
  end
  
  properties
    NumSimulations;
  end
  
  methods
    function obj = SimulationArray(variableArray, simulations)
      if nargin~=0
        obj.VariableArray = variableArray;
        obj.Simulations = simulations;
      end
    end
    
    function numSimulations = get.NumSimulations(tca)
      numSimulations = tca.VariableArray.NumValues;
    end
    
    
  end
  
  methods(Static)
    function obj = read_RCWA_file(filename)
      inputData = load(filename);
      theta = inputData(:,2);
      uniqueTheta = unique(theta);
      
      phi = inputData(:, 3);
      uniquePhi = unique(phi);
      
      va = VariableArray.create_variable_combinations({'Theta', 'Phi'}, {'deg', 'deg'}, {uniqueTheta', uniquePhi'});
      
      simResults = SimulationResults.empty(va.NumValues, 0);
      ind = 1;
      for i = 1:length(uniqueTheta)
        for j = 1:length(uniquePhi)
          angleTheta = uniqueTheta(i);
          anglePhi = uniquePhi(j);
          simulationIndices = find(inputData(:, 2) == angleTheta & inputData(:, 3) == anglePhi);
          wavelengths = inputData(simulationIndices, 1)*Constants.UnitConversions.MicronstoNM; % convert from microns to nm
          reflectionData=inputData(simulationIndices, 4);
          transmissionData=inputData(simulationIndices, 5);
          absorptionData=inputData(simulationIndices, 6);
          
          simResults(ind) = SimulationResults(wavelengths, reflectionData, transmissionData, absorptionData);
          ind = ind+1;
        end
      end
      
      obj = SimulationArray(va, simResults);
      
    end
    
    function [objS, objP] = read_TMM_file(filename)
      load(filename);      
      va = VariableArray('Theta', 'deg', RT.theta);
      
      simResultsS = SimulationResults.empty(length(RT.theta), 0);
      simResultsP = SimulationResults.empty(length(RT.theta), 0);
      wavelengths = RT.lambda*Constants.UnitConversions.MtoNM; % convert from microns to nm
      for i = 1:length(RT.theta)
        if RT.theta(i) == 90 || RT.theta(i) == -90
          reflectionDataS=ones(length(RT.Rs(:,:,:,i)), 1);
          transmissionDataS=zeros(length(RT.Ts(:,:,:,i)), 1);          
          reflectionDataP=ones(length(RT.Rs(:,:,:,i)), 1);
          transmissionDataP=zeros(length(RT.Ts(:,:,:,i)), 1);          

        else
        
          reflectionDataS=RT.Rs(:,:,:,i);
          transmissionDataS=RT.Ts(:,:,:,i);
          transmissionDataS(isnan(transmissionDataS)) = 0;
          transmissionDataS(transmissionDataS>1) = 0;
          
          
          
          reflectionDataP=RT.Rp(:,:,:,i);
          transmissionDataP=RT.Tp(:,:,:,i);
          transmissionDataP(isnan(transmissionDataP)) = 0;
          transmissionDataP(transmissionDataP>1) = 0;
        end
        absorptionDataS = 1 - reflectionDataS - transmissionDataS;
        absorptionDataP = 1 - reflectionDataP - transmissionDataP;

        %absorptionData=inputData(angles==uniqueAngles(i), 5);
        simResultsS(i) = SimulationResults(wavelengths, reflectionDataS(:), transmissionDataS(:), absorptionDataS(:));
        simResultsP(i) = SimulationResults(wavelengths, reflectionDataP(:), transmissionDataP(:), absorptionDataP(:));
      end
      
      objS = SimulationArray(va, simResultsS);
      objP = SimulationArray(va, simResultsP);

    end
    
  end
  
  
end

